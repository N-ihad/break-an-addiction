//
//  TagViewCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .themeOrange : .clear
//            if isSelected {
//                print(titleLabel.text!)
//            }
//            titleLabel.textColor = isSelected ? .black : .white
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureProperties()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func tagCellTapped() {
        print("DEBUG: tagCellTapped")
    }
    
    // MARK: - Helpers
    func configureUI() {
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(tagCellTapped))
//        contentView.addGestureRecognizer(gesture)
        
        configureProperties()
        configureSubviews()
    }
    
    func configureProperties() {
        contentView.layer.cornerRadius = 6
        layer.cornerRadius = 6
        layer.borderColor = UIColor.themeOrange.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        
    }
    
    func configureSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 9)
    }
}
