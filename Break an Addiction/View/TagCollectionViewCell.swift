//
//  TagCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

protocol TagCellCollectionViewDelegate: AnyObject {
    func tagCollectionViewCellDidSelect(_ cell: TagCollectionViewCell)
}

final class TagCollectionViewCell: UICollectionViewCell {

    weak var delegate: TagCellCollectionViewDelegate?
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.font = .tagCell
        return textLabel
    }()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .themeOrange : .clear
            textLabel.textColor = isSelected ? .black : .white
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tagCellTapped))
        contentView.addGestureRecognizer(gesture)
        
        layout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(textLabel)
        textLabel.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 9)
    }

    private func style() {
        contentView.layer.cornerRadius = 6
        layer.cornerRadius = 6
        layer.borderColor = UIColor.themeOrange.cgColor
        layer.borderWidth = 2
        clipsToBounds = true

    }

    @objc private func tagCellTapped() {
        isSelected = !isSelected
        delegate?.tagCollectionViewCellDidSelect(self)
    }
}
