//
//  ImageCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 01/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet var postImageView: UIImageView!
    
    func configure (with newsCell: News, indexPath: IndexPath?, using photoService: PhotoService) {
        if let picture = newsCell.picture {
            photoService.photo(urlString: picture).done(on: .main) { [weak self] image in self?.postImageView.image = image}.catch { print($0.localizedDescription)}
        } else {
            postImageView.image = UIImage(named: "photonotfound")
        }
    }
}
