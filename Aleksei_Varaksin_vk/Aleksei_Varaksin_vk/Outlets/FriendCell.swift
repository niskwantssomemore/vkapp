//
//  FriendCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    @IBOutlet var friendImageView: UIImageView!
    @IBOutlet var LikeControl: LikeControl!
    
    public func configure(with photo: Photo, using photoService: PhotoService) {
        photoService.photo(urlString: photo.image).done(on: .main) { [weak self] image in self?.friendImageView.image = image}.catch { print($0.localizedDescription)}
        LikeControl.likeCounter.text = "\(photo.countlikes)"
        LikeControl.owner = photo.ownerId
        LikeControl.item = photo.id
        if (photo.isliked == 1) {
            LikeControl.isLiked = true
            LikeControl.isLikedsymbol()
        }
    }
}
