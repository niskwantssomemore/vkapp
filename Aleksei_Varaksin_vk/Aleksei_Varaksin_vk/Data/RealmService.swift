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
    
    static func save<T: Object>(items: [T], config: Realm.Configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true), update: Bool = true) {
        print(config.fileURL!)
        do {
            let realm = try Realm(configuration: self.deleteIfMigration)
            try realm.write {
                realm.add(items, update: .all)
            }
        } catch {
            print(error)
        }
    }
    static func get<T: Object>(_ type: T.Type, config: Realm.Configuration = Realm.Configuration.defaultConfiguration) -> Results<T>? {
        do {
            let realm = try Realm(configuration: self.deleteIfMigration)
            return realm.objects(type)
        } catch {
            print(error)
        }
        return nil
    }
    static func delete<T: Object>(
        object: T,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(object)
        }
    }
}
