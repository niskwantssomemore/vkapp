
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
    @objc dynamic var image = ""
    
    required convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.image = json["sizes"][3]["url"].stringValue
    }
}
