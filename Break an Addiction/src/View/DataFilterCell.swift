//
//  DataFilterCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class DataFilterCell: UICollectionViewCell {

    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.font = .dataFilterNormalTab
        return textLabel
    }()
    
    override var isSelected: Bool {
        didSet {
            textLabel.font = isSelected ? .dataFilterSelectedTab : .dataFilterNormalTab
            textLabel.textColor = isSelected ? .themeOrange : .white
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        addSubview(textLabel)
        textLabel.center(inView: self)
    }
    
    private func style() {
        backgroundColor = .themeDarkGreen
    }

    func setText(_ text: String) {
        textLabel.text = text
    }
}
