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
    
    public func configure(with photo: Photo) {
        friendImageView.kf.setImage(with: URL(string: photo.image))
        LikeControl.likeCounter.text = "\(photo.countlikes)"
        if (photo.isliked == 1) {
            LikeControl.isLiked = true
            LikeControl.isLikedsymbol()
        }
    }
}
