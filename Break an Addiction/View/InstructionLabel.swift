//
//  InstructionLabel.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

class InstructionLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    required init(withInsets top: CGFloat = 5, _ bottom: CGFloat = 5, _ left: CGFloat = 5, _ right: CGFloat = 5) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
        
        configureProperties()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureProperties() {
        self.preferredMaxLayoutWidth = (UIScreen.main.bounds.width / 2) - 20
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.boldSystemFont(ofSize: 17)
        self.textColor = .white
        self.layer.cornerRadius = 6
        self.layer.borderColor = UIColor.themeOrange.cgColor
        self.layer.borderWidth = 2
        self.setMargins()
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
