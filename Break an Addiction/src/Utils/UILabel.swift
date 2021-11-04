//
//  UILabel.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation
import UIKit

extension UILabel {
    func highlightAndUnderline(searchedText: String, color: UIColor = .themeOrange) {
        guard let text = text else { return }

        let attributedText = NSMutableAttributedString(string: text)
        let range: NSRange = attributedText.mutableString.range(of: searchedText.lowercased(), options: .caseInsensitive)

        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        attributedText.addAttribute(.underlineStyle, value: 1, range: range)

        self.attributedText = attributedText
    }

    func setMargins(margin: CGFloat = 10) {
        guard let text = text else {
            return
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = margin
        paragraphStyle.headIndent = margin
        paragraphStyle.tailIndent = -margin

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )

        attributedText = attributedString
    }

    func height(for text: String, font: UIFont, width: CGFloat) -> CGFloat{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
   }
}
