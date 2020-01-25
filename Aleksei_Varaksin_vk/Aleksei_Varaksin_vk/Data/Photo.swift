
//  Photo.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 10/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    @objc dynamic var image = ""
    @objc dynamic var countlikes = 0
    @objc dynamic var isliked = 0
    var owner = LinkingObjects(fromType: User.self, property: "photos")
    
    required convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.ownerId = json["owner_id"].intValue
        self.image = json["sizes"][3]["url"].stringValue
        self.countlikes = json["likes"]["count"].intValue
        self.isliked = json["likes"]["user_likes"].intValue
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
