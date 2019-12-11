//
//  NetworkService.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 04/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    static let session: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: config)
        return session
    }()
    public func groupuser(completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
            let baseUrl = "https://api.vk.com"
            let path = "/method/groups.get"
        let params: Parameters = [
                "access_token": Session.shared.token,
                "extended": 1,
                "v": "5.103"
            ]
            
            NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    let groupJSONs = json["response"]["items"].arrayValue
                    let group = groupJSONs.map { Group(from: $0) }
                    completion?(.success(group))
                    
                case let .failure(error):
                    completion?(.failure(error))
                }
            }
        }
//    static func loadFriends(token: String) {
//        let baseUrl = "https://api.vk.com"
//        let path = "/method/friends.get"
//        
//        let params: Parameters = [
//            "access_token": token,
//            "extended": 1,
//            "v": "5.103",
//            "fields" : "domain"
//        ]
//        
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
//            guard let json = response.value else { return }
//            
//            print(json)
//        }
//    }
//    static func loadPhotos(token: String, owner_id: String) {
//        let baseUrl = "https://api.vk.com"
//        let path = "/method/photos.getAll"
//
//        let params: Parameters = [
//            "access_token": token,
//            "owner_id": owner_id,
//            "extended": 1,
//            "v": "5.92",
//        ]
//
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
//            guard let json = response.value else { return }
//
//            print(json)
//        }
//    }
}
