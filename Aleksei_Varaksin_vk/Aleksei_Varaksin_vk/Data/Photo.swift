
//  Photo.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 10/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    let id: Int
    let image: String
    
    init(from json: JSON) {
        self.id = json["id"].intValue
        self.image = json["sizes"][3]["url"].stringValue
    }
}
