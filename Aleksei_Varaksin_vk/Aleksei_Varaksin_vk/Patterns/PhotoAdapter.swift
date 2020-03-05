//
//  PhotoAdapter.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 05/03/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoAdapter {
    private let networkService = NetworkService()
    private var realmNotificationTokens: [Int: NotificationToken] = [:]
    func getphotos(id: Int, then completion: @escaping ([PhotoAdapterStruct]) -> Void) {
        guard let realm = try? Realm()
            , let realmId = realm.object(ofType: User.self, forPrimaryKey: id)
            else { return }
        self.realmNotificationTokens[id]?.invalidate()
        let token = realmId.photos.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .update(let realmPhotos, _, _, _):
                var photos: [PhotoAdapterStruct] = []
                for realmPhotos in realmPhotos {
                    photos.append(self.photo(from: realmPhotos))
                }
                self.realmNotificationTokens[id]?.invalidate()
                completion(photos)
            case .error(let error):
                fatalError("\(error)")
            case .initial:
                break
            }
        }
        self.realmNotificationTokens[id] = token
        networkService.friendphotos(for: id)
    }
    private func photo(from rlmPhoto: Photo) -> PhotoAdapterStruct {
        return PhotoAdapterStruct(id: rlmPhoto.id, ownerId: rlmPhoto.ownerId, image: rlmPhoto.image, countlikes: rlmPhoto.countlikes, isliked: rlmPhoto.isliked)
    }
}
struct PhotoAdapterStruct {
    var id: Int
    var ownerId: Int
    var image: String
    var countlikes: Int
    var isliked: Int
}
