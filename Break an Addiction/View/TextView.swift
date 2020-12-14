//
//  TextView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/13/20.
//

import UIKit

class TextView: UITextView {
    // MARK: - Properties
    private var isThereTextToSet: Bool = false
    private let placeholder: String = "e.g. don't visit alcohol sections in supermarket"
    
    // MARK: - LifeCycle
    init(frame: CGRect, text: String = "") {
        super.init(frame: CGRect.zero, textContainer: nil)
        
        delegate = self
        isThereTextToSet = text == "" ? false : true
        
        configureProperties(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureProperties(text: String) {
        self.text = isThereTextToSet ? text : placeholder
        self.textColor = isThereTextToSet ? UIColor.black : UIColor.themePlaceHolderColor
        self.backgroundColor = .white
        self.font = UIFont.systemFont(ofSize: 16)
        self.isScrollEnabled = false
    }
}

extension TextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.themePlaceHolderColor {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.themePlaceHolderColor
        }
    }
}
