//
//  LikeControl.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 15/01/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var likeCounter: UILabel!
    var isLiked = false
    var likes = 0
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupGestureRecognzer()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGestureRecognzer()
    }
    private func setupGestureRecognzer() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapOnLike))
        addGestureRecognizer(tapGR )
        tapGR.numberOfTapsRequired = 2
    }
    @objc private func tapOnLike() {
        isLiked.toggle()
        if isLiked {
            UIView.transition(with: likeImage, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.likeImage.image = UIImage(systemName: "heart.fill")
                self.likes += 1
                self.likeCounter.text = "\(self.likes)"
            }, completion: nil)
        } else {
            UIView.transition(with: likeImage, duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.likeImage.image = UIImage(systemName: "heart")
                self.likes -= 1
                self.likeCounter.text = "\(self.likes)"
            }, completion: nil)
        }
    }
}
