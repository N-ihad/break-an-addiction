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
        let lbl = InstructionLabel()
        
        return lbl
    }()
    
    private let arrowView: UIView = {
        let v = UIView()
        
        return v
    }()
    
    let solutionLabel: InstructionLabel = {
        let lbl = InstructionLabel()
        
        return lbl
    }()
    
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
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        self.contentView.backgroundColor = .themeDarkGreen

        configureSubviews()
    }
    
    func configureSubviews() {
        contentView.addSubview(triggerLabel)
        triggerLabel.centerY(inView: contentView, leftAnchor: leftAnchor, paddingLeft: 8)
        
        contentView.addSubview(solutionLabel)
        solutionLabel.centerY(inView: contentView, rightAnchor: rightAnchor, paddingRight: 8)
    }
    
    func set(trigger: String, solution: String) {
        triggerLabel.text = trigger
        solutionLabel.text = solution
    }
}

