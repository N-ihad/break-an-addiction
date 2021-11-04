//
//  AbstainingCounterView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/17/20.
//

import UIKit

final class AbstainingCounterView: UIView {

    private let counterLabel: UILabel = {
        let counterLabel = Helper().label(text: "")
        counterLabel.font = .abstainingCounter
        return counterLabel
    }()
    
    private let displayFormatLabel = Helper().label(text: "days:hours:mins:secs")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        let stack = UIStackView(arrangedSubviews: [counterLabel, displayFormatLabel])
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.pinTo(self)
    }

    func set(with counterText: String) {
        counterLabel.text = counterText
    }
}
