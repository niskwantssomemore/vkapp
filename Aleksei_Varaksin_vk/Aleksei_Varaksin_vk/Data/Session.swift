//
//  Session.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 30/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    public static let shared = Session()
    var token: String = ""
    var userId: Int = 0
}
