//
//  User.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 10/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_200_orig: String
    
    init(from json: JSON) {
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photo_200_orig = json["photo_200"].stringValue
    }
}
