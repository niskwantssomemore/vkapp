//
//  User.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 10/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var photo_200_orig = ""
    var photos = List<Photo>()
    
    required convenience init(from json: JSON, photos: [Photo] = []) {
        self.init()
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photo_200_orig = json["photo_200_orig"].stringValue
        self.photos.append(objectsIn: photos)
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
