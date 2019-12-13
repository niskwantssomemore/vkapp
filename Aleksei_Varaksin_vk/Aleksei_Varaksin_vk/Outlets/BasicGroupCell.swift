//
//  BasicGroupCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class BasicGroupCell: UITableViewCell {
    @IBOutlet var basicgroupImageView: UIImageView!
    @IBOutlet var basicgroupnameLabel: UILabel!
    
    public func configure(with group: Group) {
        basicgroupnameLabel.text = "\(group.name)"
        basicgroupImageView.kf.setImage(with: URL(string: group.image))
    }
}
