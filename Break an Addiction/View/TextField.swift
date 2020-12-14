//
//  TextField.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class TextField: UITextField {
    let inset: CGFloat = 12
    
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
        self.backgroundColor = .white
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 16)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.themePlaceHolderColor])
        self.layer.cornerRadius = 15
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // placeholder position
    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset , dy: self.inset)
    }

    // text position
    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset , dy: self.inset)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset, dy: self.inset)
    }
}
