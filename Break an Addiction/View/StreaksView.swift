//
//  StreaksView.swift
//  Break an Addiction
//
//  Created by Nihad on 12/18/20.
//

import UIKit

private let streaks = [20, 24, 14, 22, 27]

class StreaksView: UIView {
    
    // MARK: - Properties
    
    private let streaksLabel: UILabel = {
        let label = Utilities().label(text: "Streaks")
        
        return label
    }()
    
    private let verticalStreakBarViews: [StreakBarView] = {
        var views = [StreakBarView]()
        let max = Float(streaks.max()!)
        for streak in streaks {
            let view = StreakBarView()
            let multiplier = CGFloat(Float(streak)/max)
            let maxHeight: CGFloat = 126
            view.barView.setDimensions(width: 36, height: CGFloat(maxHeight) * multiplier)
            view.counterLabel.text = String(streak)
            views.append(view)
        }

        
        return views
    }()
    
    private let streakCounterLabel: UILabel = {
        let label = Utilities().label(text: "")
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 263, height: 182)) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: verticalStreakBarViews)
        addSubview(stack)
        stack.setDimensions(width: 263, height: 158)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.centerX(inView: self)
        stack.anchor(bottom: self.bottomAnchor, paddingBottom: 0)
        
        addSubview(streaksLabel)
        streaksLabel.centerX(inView: self)
        streaksLabel.anchor(bottom: stack.topAnchor, paddingBottom: 10)
    }
}

fileprivate class StreakBarView: UIView {
    
    let barView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 60))
        view.layer.cornerRadius = 8
        view.backgroundColor = .green
//        view.setDimensions(width: 36, height: 60)
        
        return view
    }()
    
    let counterLabel: UILabel = {
        let label = Utilities().label(text: "24")
        
        return label
    }()
    
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 36, height: 160)) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(counterLabel)
        counterLabel.centerX(inView: self)
        counterLabel.anchor(bottom: self.bottomAnchor, paddingBottom: 0)
        
        addSubview(barView)
        barView.centerX(inView: self)
        barView.anchor(bottom: counterLabel.topAnchor, paddingBottom: 5)
    }
}
