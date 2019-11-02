//
//  AvatarView.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 02/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

@IBDesignable class AvatarView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 75
    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var borderWidth: CGFloat = 0.5
    private var customBackgroundColor = UIColor.white
    override var backgroundColor: UIColor?{
        didSet {
            customBackgroundColor = backgroundColor!
            super.backgroundColor = UIColor.clear
        }
    }
    
    func setup() {
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowRadius = 5.0;
        layer.shadowOpacity = 0.5;
        super.backgroundColor = UIColor.clear
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override func draw(_ rect: CGRect) {
        customBackgroundColor.setFill()
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ).fill()

        let borderRect = bounds.insetBy(dx: borderWidth/2, dy: borderWidth/2)
        let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: cornerRadius - borderWidth/2)
        borderColor.setStroke()
        borderPath.lineWidth = borderWidth
        borderPath.stroke()
    }
}
extension UIImageView{

    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
    }

}
