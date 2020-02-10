//
//  GroupCell.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class AddedGroupCell: UITableViewCell {
    let addedgroupnameLabel = UILabel()
    let addedgroupImageView = UIImageView()
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
        contentView.addSubview(addedgroupnameLabel)
        addedgroupnameLabel.backgroundColor = .white
        contentView.addSubview(addedgroupImageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutaddedgroupnameLabel()
        layoutaddedgroupImageView()
    }
    private func layoutaddedgroupnameLabel() {
        let labelSize = addedgroupnameLabel.intrinsicContentSize.width
        addedgroupnameLabel.frame = CGRect(x: 100, y: 15, width: labelSize, height: iconSize)
    }
    private func layoutaddedgroupImageView() {
        addedgroupImageView.frame = CGRect(x: 30, y: 15, width: iconSize, height: iconSize)
    }
    public func configure(with group: Group, using photoService: PhotoService) {
        addedgroupnameLabel.text = "\(group.name)"
        photoService.photo(urlString: group.image).done(on: .main) { [weak self] image in self?.addedgroupImageView.image = image}.catch { print($0.localizedDescription)}
    }
}
