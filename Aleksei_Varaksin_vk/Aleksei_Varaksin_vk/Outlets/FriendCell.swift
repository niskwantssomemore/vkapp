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
    
    public func configure(with viewModel: PhotoModel, using photoService: PhotoService) {
        photoService.photo(urlString: viewModel.photoImage).done(on: .main) { [weak self] image in self?.friendImageView.image = image}.catch { print($0.localizedDescription)}
        LikeControl.likeCounter.text = viewModel.likesText
        LikeControl.owner = viewModel.owner
        LikeControl.item = viewModel.item
        if (viewModel.isLiked == 1) {
            LikeControl.isLiked = true
            LikeControl.isLikedsymbol()
        }
    }
}
