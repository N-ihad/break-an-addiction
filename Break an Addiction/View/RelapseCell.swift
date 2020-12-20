//
//  RelapseCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//


import UIKit

protocol RelapseCellDelegate: class {
    func handleCellPressed(_ cell: RelapseCell)
}

class RelapseCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: RelapseCellDelegate?
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func cellTapped() {
        self.contentView.backgroundColor = .lightGray
        UIView.animate(withDuration: 0.5) {
            self.contentView.backgroundColor = .themeDarkGreen
        }
        self.delegate?.handleCellPressed(self)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.contentView.backgroundColor = .themeDarkGreen

        configureSubviews()
    }
    
    func configureSubviews() {
        contentView.addSubview(title)
        title.centerY(inView: contentView, leftAnchor: leftAnchor, paddingLeft: 14)
    }
    
    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        
        self.addGestureRecognizer(gesture)
    }
    
    func set(relapse: Relapse) {
        self.title.text = relapse.date.toString
    }
}
