//
//  InstructionLabel.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class InstructionLabel: UILabel {

    private let topInset: CGFloat
    private let bottomInset: CGFloat
    private let leftInset: CGFloat
    private let rightInset: CGFloat

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }

    init(top: CGFloat = 5, bottom: CGFloat = 5, left: CGFloat = 5, right: CGFloat = 5) {
        (topInset, bottomInset) = (top, bottom)
        (leftInset, rightInset) = (left, right)
        super.init(frame: .zero)
        
        style()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    private func style() {
        preferredMaxLayoutWidth = (UIScreen.main.bounds.width / 2) - 20
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        font = .instructionCell
        textColor = .white
        layer.cornerRadius = 6
        layer.borderColor = UIColor.themeOrange.cgColor
        layer.borderWidth = 2
        setMargins()
    }
}
