//
//  Utilities.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class Utilities {
    
    enum hintImageStyle: String {
        case thick = "thick"
        case medium = "medium"
        case thin = "thin"
        case normal = "hint"
    }
    
    func button(text: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(text, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.dropShadow(color: .black, opacity: 0.75, offSet: CGSize.zero, radius: 8)
        btn.setDimensions(width: btn.frame.width + 80, height: 38)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return btn
    }
    
    func labelCaptionForTextField(text: String, highlightAndUnderlineSubstring: String? = nil) -> UILabel {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.41])
        if let substr = highlightAndUnderlineSubstring {
            lbl.highlightAndUnderline(searchedText: substr)
        }
        
        return lbl
    }
    
    func hintView(text: String, style: hintImageStyle) -> UIView {
        let view = UIView()
        
        let iv = UIImageView() // CGRect(x: 0, y: 0, width: 15, height: 25)
        iv.image = UIImage(named: style.rawValue)
        view.addSubview(iv)
        iv.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 2)
        
        let hintLabel = UILabel()
        hintLabel.font = UIFont.boldSystemFont(ofSize: 9)
        hintLabel.text = text
        view.addSubview(hintLabel)
        hintLabel.centerX(inView: view, topAnchor: iv.bottomAnchor, paddingTop: 3)
        
        view.setDimensions(width: hintLabel.intrinsicContentSize.width, height: 40)
        
        return view
    }
}

