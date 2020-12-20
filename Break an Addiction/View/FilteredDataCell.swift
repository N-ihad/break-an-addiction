//
//  FilteredDataCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

class FilteredDataCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 15)
            titleLabel.textColor = isSelected ? .themeOrange : .white
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    func configureUI() {
        backgroundColor = .themeDarkGreen
    }
}
