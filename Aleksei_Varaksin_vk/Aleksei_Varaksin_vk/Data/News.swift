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

class News {
//    @objc dynamic var postId = 0
//    @objc dynamic var sourceId = 0
//    @objc dynamic var newsPhoto = ""
//    @objc dynamic var newsText = ""
//    @objc dynamic var avatar = ""
//    @objc dynamic var avatarWidth = 0
//    @objc dynamic var avatarHeight = 0
//    @objc dynamic var countLikes = 0
//    @objc dynamic var isLiked = 0
//    @objc dynamic var countComments = 0
//    @objc dynamic var countReposts = 0
//    @objc dynamic var isReposted = 0
//    @objc dynamic var totalViews = 0
//    @objc dynamic var newsHeader = ""
//
//    required convenience init(from json: JSON) {
//        self.init()
//    }
//    override static func primaryKey() -> String? {
//        return "postId"
//    }
    var title: String
    var content: String
    var date: String
    var picture: String?
    var likes: Int? = 0
    var comments: Int? = 0
    var views: Int? = 0
    var shared: Int? = 0
    var isLiked: Bool? = false
    var isShared: Bool? = false
    var avatar: String?
    init (title: String, content: String, date: String, picture: String?, likes: Int, views: Int, comments: Int, shared: Int, isLiked: Bool, avatar: String?, isShared: Bool) {
        self.title = title
        self.content = content
        self.date = date
        self.picture = picture
        self.likes = likes
        self.comments = comments
        self.views = views
        self.shared = shared
        self.isLiked = isLiked
        self.avatar = avatar
        self.isShared = isShared
    }
}
