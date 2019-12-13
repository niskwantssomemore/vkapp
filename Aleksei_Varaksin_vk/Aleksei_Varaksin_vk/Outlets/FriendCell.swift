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
    
    public func configure(with photo: Photo) {
        friendImageView.kf.setImage(with: URL(string: photo.image))
    }
}
