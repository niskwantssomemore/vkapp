//
//  Group.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 10/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group {
    let id: Int
    let name: String
    let image: String
    
    init(from json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.image = json["photo_200"].stringValue
    }
}
