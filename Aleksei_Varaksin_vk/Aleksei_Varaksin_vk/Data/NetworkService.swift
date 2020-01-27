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
    static let session: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        let session = Alamofire.SessionManager(configuration: config)
        return session
    }()
    private var news = [News]()
    private var friends = [User]()
    private var groups = [Group]()
    public func frienduser(photos: [Photo] = [], completion: @escaping ([User]) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "order": "name",
            "fields": "photo_200_orig",
            "v": "5.103"
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                let friendJSONs = json["response"]["items"].arrayValue
                let friend = friendJSONs.map { User(from: $0, photos: photos) }
                completion(friend)

            case let .failure(error):
                print(error)
            }
        }
    }
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
    public func grouprecomend(completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.getCatalog"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "category_id": 1,
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
    public func friendphotos(for id: Int, completion: @escaping ([Photo]) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/photos.getAll"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "owner_id": id,
            "extended": 1,
            "photo_sizes": 1,
            "no_service_albums": 0,
            "v": "5.103"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                var photos = json["response"]["items"].arrayValue.map { json in return Photo(from: json)}
                var sortPhoto: [Photo] = []
                for photo in photos {
                    if photo.image != "" {
                        sortPhoto.append(photo)
                    }
                }
                photos = sortPhoto
                completion(photos)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    public func groupsearch(search: String, completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.search"
        let params: Parameters = [
            "access_token": Session.shared.token,
            "q": search,
            "count": 20,
            "type": "group, page",
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
    public func likeadd(liketype: String, ownerId: Int, itemId: Int) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/likes.add"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "type": liketype,
            "owner_id": ownerId,
            "item_id": itemId,
            "v": "5.103"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
//            case .success(_): break
//            case .failure(_): break
                case .success(_): print(response)
                case .failure(_): print(response)
            }
        }
    }
    public func likeremove(liketype: String, ownerId: Int, itemId: Int) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/likes.delete"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "type": liketype,
            "owner_id": ownerId,
            "item_id": itemId,
            "v": "5.103"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(_): break
            case .failure(_): break
            }
        }
    }
    public func groupadd(groupId: Int) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.join"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "group_id": groupId,
            "v": "5.103"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(_): break
            case .failure(_): break
            }
        }
    }
    public func groupremove(groupId: Int) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.leave"
    let params: Parameters = [
            "access_token": Session.shared.token,
            "group_id": groupId,
            "v": "5.103"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(_): break
            case .failure(_): break
            }
        }
    }
    public func getnews(completion: (([News]?, Error?) -> Void)? = nil ) {
        DispatchQueue.global(qos: .utility).async {
            let baseUrl = "https://api.vk.com"
            let path = "/method/newsfeed.get"
            let params: Parameters = [
                "access_token": Session.shared.token,
                "filters": "post, photo",
                "max_photos": "1",
                "v": "5.103"
            ]
            
            NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.news = json["response"]["items"].arrayValue.map { News(from: $0)}
                    self.friends = json["response"]["profiles"].arrayValue.map { User(from: $0)}
                    self.groups = json["response"]["groups"].arrayValue.map { Group(from: $0)}
                    self.news = (self.news.filter { $0.newsText != "" || $0.imageURLstring != "" })
                    self.checksource()
                    completion?(self.news, nil)
                case .failure(let error):
                    completion?(nil, error)
                }
            }
        }
    }
    public func checksource() {
        for post in self.news {
            if post.sourceId > 0 {
                let index = friends.firstIndex(where: { (item) -> Bool in
                    item.id == post.sourceId
                })
                post.newsHeader = "\(friends[index!].first_name) \(friends[index!].last_name)"
                post.newsPhoto = friends[index!].photo_200_orig
            } else {
                let index = groups.firstIndex(where: { (item) -> Bool in
                    item.id == post.sourceId * -1
                })
                post.newsHeader = groups[index!].name
                post.newsPhoto = groups[index!].image
            }
        }
    }
}
