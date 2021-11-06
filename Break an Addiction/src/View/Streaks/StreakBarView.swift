//
//  StreakBarView.swift
//  Break an Addiction
//
//  Created by Nihad on 11/4/21.
//

import Foundation
import UIKit

final class StreakBarView: UIView {

    let barView: UIView = {
        let barView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 60))
        barView.layer.cornerRadius = 8
        barView.backgroundColor = .green
        return barView
    }()

    let counterLabel = Helper.makeLabel(text: "24")

    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 36, height: 160)) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        addSubview(counterLabel)
        counterLabel.centerX(inView: self)
        counterLabel.anchor(bottom: bottomAnchor, paddingBottom: 0)

        addSubview(barView)
        barView.centerX(inView: self)
        barView.anchor(bottom: counterLabel.topAnchor, paddingBottom: 5)
    }
}
