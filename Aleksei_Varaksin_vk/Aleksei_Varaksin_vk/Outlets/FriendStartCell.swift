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
    
    public func configure(with friend: User, using photoService: PhotoService) {
        FriendStartLabel.text = "\(friend.first_name) \(friend.last_name)"
        photoService.photo(urlString: friend.photo_200_orig).done(on: .main) { [weak self] image in self?.FriendStartImageView.image = image}.catch { print($0.localizedDescription)}
    }
}
