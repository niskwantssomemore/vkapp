//
//  GroupCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupnameLabel: UILabel!
    
    public func configure(with group: Group, using photoService: PhotoService) {
        groupnameLabel.text = "\(group.name)"
        photoService.photo(urlString: group.image).done(on: .main) { [weak self] image in self?.groupImageView.image = image}.catch { print($0.localizedDescription)}
    }
}
