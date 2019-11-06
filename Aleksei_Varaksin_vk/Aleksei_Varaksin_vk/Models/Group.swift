//
//  Group.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class Group {
    let image: UIImage?
    let name: String
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    init(name: String) {
        self.image = nil
        self.name = name
    }
}
