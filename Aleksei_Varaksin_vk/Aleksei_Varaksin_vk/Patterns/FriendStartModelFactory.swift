//
//  FriendStartModelFactory.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 05/03/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class FriendViewModelFactory {
    func constructViewModels(from photos: [PhotoAdapterStruct]) -> [PhotoModel] {
        return photos.compactMap(self.viewModel)
    }
    private func viewModel(from photo: PhotoAdapterStruct) -> PhotoModel {
        let photoImage = photo.image
        let likesText = "\(photo.countlikes)"
        let item = photo.id
        let owner = photo.ownerId
        let isLiked = photo.isliked
        return PhotoModel(photoImage: photoImage, likesText: likesText, item: item, owner: owner, isLiked: isLiked)
    }
}
struct PhotoModel {
    let photoImage: String
    let likesText: String
    let item: Int
    let owner: Int
    let isLiked: Int
}
