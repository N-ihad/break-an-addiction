//
//  InstructionCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class InstructionsTableViewCell: UITableViewCell {

    private let triggerLabel = InstructionLabel()
    private let arrowView = UIView()
    private let reactionLabel = InstructionLabel()
    
    private let instructions: [Trigger : Reaction]? = nil

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout()
        self.style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(triggerLabel)
        triggerLabel.centerY(inView: contentView, leftAnchor: leftAnchor, paddingLeft: 8)
        
        contentView.addSubview(reactionLabel)
        reactionLabel.centerY(inView: contentView, rightAnchor: rightAnchor, paddingRight: 8)
    }

    private func style() {
        contentView.backgroundColor = .themeDarkGreen
    }
    
    func set(with triggerName: String, _ reactionName: String) {
        triggerLabel.text = triggerName
        reactionLabel.text = reactionName
    }
}

