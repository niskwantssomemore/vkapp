//
//  LoadView.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 13/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class LoadView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.frame.size.width = 20
        self.frame.size.height = 20
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        //self.layer.cornerRadius = self.frame.size.width / 2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}
