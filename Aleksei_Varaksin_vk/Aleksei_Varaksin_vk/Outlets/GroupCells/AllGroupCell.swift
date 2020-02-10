//
//  BasicGroupCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class AllGroupCell: UITableViewCell {
    let allgroupnameLabel = UILabel()
    let allgroupImageView = UIImageView()
    private let iconSize: CGFloat = 50
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    private func setupSubviews() {
        contentView.addSubview(allgroupnameLabel)
        allgroupnameLabel.backgroundColor = .white
        contentView.addSubview(allgroupImageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutallgroupnameLabel()
        layoutallgroupImageView()
    }
    private func layoutallgroupnameLabel() {
        let labelSize = allgroupnameLabel.intrinsicContentSize.width
        allgroupnameLabel.frame = CGRect(x: 100, y: 15, width: labelSize, height: iconSize)
    }
    private func layoutallgroupImageView() {
        allgroupImageView.frame = CGRect(x: 30, y: 15, width: iconSize, height: iconSize)
    }
    public func configure(with group: Group, using photoService: PhotoService) {
        allgroupnameLabel.text = "\(group.name)"
        photoService.photo(urlString: group.image).done(on: .main) { [weak self] image in self?.allgroupImageView.image = image}.catch { print($0.localizedDescription)}
    }
}
