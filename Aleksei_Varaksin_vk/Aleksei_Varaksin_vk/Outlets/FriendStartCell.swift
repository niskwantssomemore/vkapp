//
//  FriendStart.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 29/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import Kingfisher

class FriendStartCell: UITableViewCell {
    @IBOutlet var FriendStartImageView: UIImageView!
    @IBOutlet var FriendStartLabel: UILabel!
    
    public func configure(with friend: User) {
        FriendStartLabel.text = "\(friend.first_name) \(friend.last_name)"
        FriendStartImageView.kf.setImage(with: URL(string: friend.photo_200_orig))
    }
}
