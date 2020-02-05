//
//  LikeCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 01/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class LikeCell: UITableViewCell {
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentImage: UIImageView!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var repostImage: UIImageView!
    @IBOutlet var repostsLabel: UILabel!
    @IBOutlet var viewImage: UIImageView!
    @IBOutlet var viewsLabel: UILabel!

    func configure (with newsCell: News, indexPath: IndexPath?){
        repostsLabel.text = String(newsCell.shared!)
        viewsLabel.text = String(newsCell.views!)
        commentsLabel.text = String(newsCell.comments!)
        likesLabel.text = String(newsCell.likes!)
        if newsCell.isLiked! == true {
            likeImage.image = UIImage(systemName: "heart.fill")
        } else { likeImage.image = UIImage(systemName: "heart") }
        if newsCell.isShared! == true {
            repostImage.image = UIImage(systemName: "repeat.1")
        } else { repostImage.image = UIImage(systemName: "repeat") }
    }
}
