//
//  RealmService.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 22/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
//        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
}
