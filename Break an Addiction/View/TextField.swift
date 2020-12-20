//
//  TextField.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class TextField: UITextField {
    let inset: CGFloat = 10
    
    init(frame: CGRect, placeholder: String) {
        super.init(frame: frame)
        
        configureProperties(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureProperties(placeholder: String) {
        self.placeholder = placeholder
        self.backgroundColor = .clear
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 16)
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.themePlaceHolderColor])
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        let metrics = ["width" : NSNumber(value: 1)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|",
                                                           options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|",
                                                           options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: metrics,
                                                           views: views))
    }
    
    // placeholder position
    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset , dy: 0)
    }

    // text position
    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset , dy: 0)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset, dy: 0)
    }
}
