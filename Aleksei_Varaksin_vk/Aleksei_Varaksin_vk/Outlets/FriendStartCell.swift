//
//  FriendStart.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 29/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class FriendStartCell: UITableViewCell {
    @IBOutlet var FriendStartImageView: UIImageView!
    @IBOutlet var FriendStartLabel: UILabel!
    @IBOutlet var avatarView: AvatarView!
    override func awakeFromNib() {
        FriendStartImageView.asCircle()
    }
}
