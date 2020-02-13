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
    var title: String
    var content: String
    var date: Double
    var picture: String?
    var likes: Int? = 0
    var comments: Int? = 0
    var views: Int? = 0
    var shared: Int? = 0
    var isLiked: Bool? = false
    var isShared: Bool? = false
    var avatar: String?
    init (title: String, content: String, date: Double, picture: String?, likes: Int, views: Int, comments: Int, shared: Int, isLiked: Bool, avatar: String?, isShared: Bool) {
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
