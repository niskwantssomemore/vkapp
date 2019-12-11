//
//  GroupCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import Kingfisher

class GroupCell: UITableViewCell {
    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupnameLabel: UILabel!
    
    public func configure(with group: Group) {
        groupnameLabel.text = "\(group.name)"
        groupImageView.kf.setImage(with: URL(string: group.image))
    }
}
