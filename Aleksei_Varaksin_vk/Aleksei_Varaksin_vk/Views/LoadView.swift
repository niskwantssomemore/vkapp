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
        self.layer.borderWidth = 1.0
        self.frame.size.width = 25
        self.frame.size.height = 25
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}
