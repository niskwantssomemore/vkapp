//
//  HeaderCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 01/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var hostLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var mainTextLabel: UILabel!
    
    func configure (with newsCell: News, indexPath: IndexPath?, using photoService: PhotoService) {
        hostLabel.text = newsCell.title
        timeLabel.text = newsCell.date
        mainTextLabel.text = newsCell.content
        
        if let avatar = newsCell.avatar {
            photoService.photo(urlString: avatar).done(on: .main) { [weak self] image in self?.avatarImageView.image = image}.catch { print($0.localizedDescription)}
        } else {
            avatarImageView.image = UIImage(named: "photonotfound")
        }
    }
}
