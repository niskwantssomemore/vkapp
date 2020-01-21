//
//  News.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 22/01/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class News: Object {
    @objc dynamic var postId = 0
    @objc dynamic var sourceId = 0
    @objc dynamic var newsPhoto = ""
    @objc dynamic var newsText = ""
    @objc dynamic var imageURLstring = ""
    @objc dynamic var imageHeight = 0
    @objc dynamic var imageWidth = 0
    @objc dynamic var countLikes = 0
    @objc dynamic var isLiked = 0
    @objc dynamic var countComments = 0
    @objc dynamic var countReposts = 0
    @objc dynamic var isReposted = 0
    @objc dynamic var totalViews = 0
    
    required convenience init(from json: JSON) {
        self.init()
        self.postId = json["post_id"].intValue
        self.sourceId = json["source_id"].intValue
        self.newsPhoto = json["photo_100"].stringValue
        self.newsText = json["text"].stringValue
        self.countLikes = json["likes"]["count"].intValue
        self.isLiked = json["likes"]["user_likes"].intValue
        self.countComments = json["comments"]["count"].intValue
        self.countReposts = json["reposts"]["count"].intValue
        self.isReposted = json["reposts"]["user_reposted"].intValue
        self.totalViews = json["views"]["count"].intValue
        if json["type"] == "post" {
            for size in json["attachments"][0]["photo"]["sizes"].arrayValue {
                if size["type"].stringValue == "x" {
                    self.imageURLstring = size["url"].stringValue
                    self.imageWidth = size["width"].intValue
                    self.imageHeight = size["height"].intValue
                }
            }
        } else {
            for size in json["photos"]["items"][0]["sizes"].arrayValue {
                if size["type"].stringValue == "x" {
                    self.imageURLstring = size["url"].stringValue
                    self.imageWidth = size["width"].intValue
                    self.imageHeight = size["height"].intValue
                }
            }
        }
    }
    override static func primaryKey() -> String? {
        return "postId"
    }
}
