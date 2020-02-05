//
//  PhotoService.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 01/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class PhotoService {
    private var cacheLifetime: TimeInterval = 60*60*24*7
    private static var memoryCache = [String: UIImage]()
    private let isolationQ = DispatchQueue(label: "photoservice.iso")
    
    private var imageCacheUrl: URL? {
        let dirname = "Images"
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let url = cacheDir.appendingPathComponent(dirname, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        return url
    }
    private func getFilePath(urlString: String) -> URL? {
        let filename = urlString.split(separator: "/").last ?? "default.png"
        guard let imageCacheUrl = self.imageCacheUrl else { return nil }
        return imageCacheUrl.appendingPathComponent(String(filename))
    }
    private func saveImageToFilesystem(urlString: String, image: UIImage) {
        guard let data = image.pngData(),
            let fileUrl = getFilePath(urlString: urlString) else { return }
        try? data.write(to: fileUrl)
    }
    private func loadImageFromFilesystem(urlString: String) -> UIImage? {
        guard let fileUrl = getFilePath(urlString: urlString),
            let info = try? FileManager.default.attributesOfItem(atPath: fileUrl.absoluteString),
            let modificationDate = info[.modificationDate] as? Date else { return nil }
        let imageLifetime = Date().distance(to: modificationDate)
        guard imageLifetime < cacheLifetime,
            let image = UIImage(contentsOfFile: fileUrl.absoluteString) else { return nil }
        isolationQ.async {
            PhotoService.memoryCache[urlString] = image
        }
        return image
    }
    private func loadImage(urlString: String) -> Promise<UIImage> {
        Alamofire.request(urlString)
            .responseData()
            .map { (data, _) -> UIImage in
                guard let image = UIImage(data: data) else { throw PMKError.badInput }
                return image }
            .get(on: isolationQ) {
                PhotoService.memoryCache[urlString] = $0
        }
            .get {
                self.saveImageToFilesystem(urlString: urlString, image: $0)
        }
    }
    public func photo(urlString: String) -> Promise<UIImage> {
        if let image = PhotoService.memoryCache[urlString] {
            return Promise.value(image)
        } else
            if let image = loadImageFromFilesystem(urlString: urlString) {
            return Promise.value(image)
        }
        return loadImage(urlString: urlString)
    }
}
