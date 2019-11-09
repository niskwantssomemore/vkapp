//
//  Person.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 09/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class Person {
    let image: UIImage?
    let name: String
    let surname: String
    
    init(image: UIImage, name: String, surname: String) {
        self.image = image
        self.name = name
        self.surname = surname
    }
}
