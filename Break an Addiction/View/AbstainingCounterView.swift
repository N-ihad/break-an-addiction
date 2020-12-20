//
//  AbstainingCounterView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/17/20.
//

import UIKit

class AbstainingCounterView: UIView {
    
    // MARK: - Properties
    
    let counterLabel: UILabel = {
        let counterLabel = Utilities().label(text: "")
        counterLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        return counterLabel
    }()
    
    let displayFormat: UILabel = {
        let displayFormat = Utilities().label(text: "days:hours:mins:secs")
        
        return displayFormat
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: [counterLabel, displayFormat])
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        stack.pinTo(self)
    }
}
