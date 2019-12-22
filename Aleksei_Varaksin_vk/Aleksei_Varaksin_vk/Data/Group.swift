//
//  Group.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 10/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    
    required convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.image = json["photo_200"].stringValue
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
