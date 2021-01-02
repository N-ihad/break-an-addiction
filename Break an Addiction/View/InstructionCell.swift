//
//  InstructionCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

class InstructionCell: UITableViewCell {
    
    // MARK: - Properties
    
    let triggerLabel: InstructionLabel = {
        let triggerLabel = InstructionLabel()
        
        return triggerLabel
    }()
    
    private let arrowView: UIView = {
        let arrowView = UIView()
        
        return arrowView
    }()
    
    let reactionLabel: InstructionLabel = {
        let reactionLabel = InstructionLabel()
        
        return reactionLabel
    }()
    
    let instruction: [Trigger : Reaction]? = nil
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0))
//    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.contentView.backgroundColor = .themeDarkGreen

        configureSubviews()
    }
    
    func configureSubviews() {
        contentView.addSubview(triggerLabel)
        triggerLabel.centerY(inView: contentView, leftAnchor: leftAnchor, paddingLeft: 8)
        
        contentView.addSubview(reactionLabel)
        reactionLabel.centerY(inView: contentView, rightAnchor: rightAnchor, paddingRight: 8)
    }
    
    func set(triggerName: String, reactionName: String) {
        triggerLabel.text = triggerName
        reactionLabel.text = reactionName
    }
}

