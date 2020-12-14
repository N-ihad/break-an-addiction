//
//  InputView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/13/20.
//

import UIKit

class InputView: UIView {
    // MARK: - Properties
    let textView: TextView = TextView(frame: CGRect())
    
    private let isEnjoyableHintView: UIView = {
        let v = Utilities().hintView(text: "Is enjoyable", style: .normal)
        
        return v
    }()
    
    private let easyToDoHintView: UIView = {
        let v = Utilities().hintView(text: "Easy to do", style: .normal)
        
        return v
    }()
    
    private let isHealthyHintView: UIView = {
        let v = Utilities().hintView(text: "Is healthy", style: .normal)
        
        return v
    }()
    
    private let generateSolutionToTriggerButton: UIButton = {
        let btn = Utilities().button(text: "Gen")
        btn.dropShadow()
        btn.backgroundColor = UIColor.themeGreen
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureProperties()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureProperties() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
    }
    
    func configureSubviews() {
        addSubview(textView)
        
        let stack = UIStackView(arrangedSubviews: [isEnjoyableHintView, easyToDoHintView, isHealthyHintView])
        addSubview(stack)
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        
        stack.centerX(inView: self)
        stack.anchor(bottom: self.bottomAnchor, paddingBottom: 10)
        
        textView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: stack.topAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 10, paddingRight: 8)
    }
}
