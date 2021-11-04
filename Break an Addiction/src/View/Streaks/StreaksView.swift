//
//  StreaksView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import UIKit

private let streaks = [20, 24, 14, 22, 27]

final class StreaksView: UIView {
    
    private let streaksLabel = Helper().label(text: "Streaks")
    
    private let verticalStreakBarViews: [StreakBarView] = {
        var views = [StreakBarView]()
        let max = Float(streaks.max()!)

        streaks.forEach { streak in
            let view = StreakBarView()
            let multiplier = CGFloat(Float(streak) / max)
            let maxHeight: CGFloat = 126
            view.barView.setDimensions(width: 36, height: CGFloat(maxHeight) * multiplier)
            view.counterLabel.text = String(streak)
            views.append(view)
        }

        return views
    }()
    
    private let streakCounterLabel = Helper().label(text: "")

    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 263, height: 182)) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        let stack = UIStackView(arrangedSubviews: verticalStreakBarViews)
        addSubview(stack)
        stack.setDimensions(width: 263, height: 158)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.centerX(inView: self)
        stack.anchor(bottom: bottomAnchor, paddingBottom: 0)
        
        addSubview(streaksLabel)
        streaksLabel.centerX(inView: self)
        streaksLabel.anchor(bottom: stack.topAnchor, paddingBottom: 10)
    }
}
