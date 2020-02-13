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
    private var users = [User]()
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
            case .success(_): break
            case .failure(_): break
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
    public func getnews(from json: JSON, complition: @escaping ([News]) -> Void) {
        var sourceList = [Int:[[String:String]]]()
        var NewsList = [News]()
        guard let items = json["response"]["items"].array else { return complition(NewsList) }
        let parsingDataGroupDispatch = DispatchGroup()
        if items.count == 0 {
            complition(NewsList)
        }
        DispatchQueue.global().async(group: parsingDataGroupDispatch) {
            if let groups = json["response"]["groups"].array,
                groups.count > 0 {
                for group in groups {
                    if let gID = group["id"].int,
                        let gName = group["name"].string,
                        let gAvatar = group["photo_50"].string
                    {
                        sourceList[gID] = [["name": gName], ["avatar": gAvatar]]
                    }
                }
            }
            if let profiles = json["response"]["profiles"].array,
                profiles.count > 0 {
                for profile in profiles {
                    if let pID = profile["id"].int,
                        let pFirstName = profile["first_name"].string,
                        let pLastName = profile["last_name"].string,
                        let pAvatar = profile["photo_50"].string
                    {
                        sourceList[pID] = [["name": pFirstName + " " + pLastName], ["avatar": pAvatar]]
                    }
                }
            }
        }
        let parsingNewsDispatchGroup = DispatchQueue(label: "parsingNewsQueue")
        parsingDataGroupDispatch.notify(queue: parsingNewsDispatchGroup) {
            for item in items {
                if var sourceId = item["source_id"].int,
                    let date = item["date"].double,
                    let text = item["text"].string,
                    !text.isEmpty
                {
                    var title = "Без названия"
                    var avatar: String?
                    var picture: String?
                    if sourceId < 0 {
                        sourceId = sourceId * -1
                    }
                    if let sObj = sourceList[sourceId],
                        let sName = sObj[0]["name"],
                        let sAvatar = sObj[1]["avatar"] {
                        title = sName
                        avatar = sAvatar
                    }
                    if let attachments = item["attachments"].array {
                        let photos = attachments.filter({ $0["type"].stringValue == "photo" })
                        var pSizeArray = [JSON]()
                        if photos.count == 0 {
                            let pLink = attachments.filter({ $0["type"].stringValue == "link" })
                            if pLink.count > 0 {
                                pSizeArray = pLink[0]["link"]["photo"]["sizes"].arrayValue
                            }
                        } else {
                            pSizeArray = photos[0]["photo"]["sizes"].arrayValue
                        }
                        if pSizeArray.count > 0 {
                            let pArr = pSizeArray.filter({ $0["type"].stringValue == "y" || $0["type"].stringValue == "l" || $0["type"].stringValue == "m" || $0["type"].stringValue == "r" })
                            let pSizeCount = pArr.count
                            if pSizeCount == 1 {
                                picture = pArr[0]["url"].stringValue
                            } else if pSizeCount > 1 {
                                for i in 0..<pSizeCount {
                                    picture = pArr[i]["url"].stringValue
                                    if pArr[i]["type"].stringValue == "y" {
                                        break
                                    }
                                }
                            }
                        }
                    }
                    let likes = item["likes"]["count"].int ?? 0
                    let isLiked = (item["likes"]["user_likes"].intValue == 0 ? false : true)
                    let comments = item["comments"]["count"].int ?? 0
                    let views = item["views"]["count"].int ?? 0
                    let shared = item["reposts"]["count"].int ?? 0
                    let isShared = (item["reposts"]["user_reposted"].intValue == 0 ? false : true)
                    NewsList.append(News(title: title, content: text, date: date, picture: picture, likes: likes, views: views, comments: comments, shared: shared, isLiked: isLiked, avatar: avatar, isShared: isShared))
                }
            }
            DispatchQueue.main.async {
                complition(NewsList)
            }
        }
    }
    public func getNewsList(startTime: Double? = nil, startFrom: String? = nil, completion: @escaping ((Swift.Result<([News], String), Error>) -> Void) ) {
        let token = Session.shared.token
        let baseUrl = "https://api.vk.com"
        let path = "/method/newsfeed.get"
        if !token.isEmpty {
            var params: Parameters = [
                "access_token": token,
                "filters": "post",
                "return_banned": 0,
                "count": 20,
                "v": "5.103",
                "fields":"nickname,photo_50"
            ]
            if let startTime = startTime {
                params.updateValue(String(startTime), forKey: "start_time")
            }
            if let startFrom = startFrom {
               params.updateValue(startFrom, forKey: "start_from")
            }
            NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    let nextFrom = json["response"]["next_from"].stringValue
                    self.getnews(from: json) { NewsList in
                        completion(.success((NewsList, nextFrom)))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }                
            }
        }
    }
}
