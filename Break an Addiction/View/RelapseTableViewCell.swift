//
//  RelapseCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//


import UIKit

protocol RelapseTableViewCellDelegate: AnyObject {
    func relapseTableViewCellDidSelect(_ cell: RelapseTableViewCell)
}

final class RelapseTableViewCell: UITableViewCell {

    var delegate: RelapseTableViewCellDelegate?
    
    private let relapseTitleLabel: UILabel = {
        let relapseTitleLabel = UILabel()
        relapseTitleLabel.textColor = .white
        relapseTitleLabel.font = .instructionCell
        return relapseTitleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
        self.style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(gesture)
    }

    private func layout() {
        contentView.addSubview(relapseTitleLabel)
        relapseTitleLabel.centerY(inView: contentView, leftAnchor: leftAnchor, paddingLeft: 14)
    }

    private func style() {
        contentView.backgroundColor = .themeDarkGreen
    }

    @objc private func cellTapped() {
        contentView.backgroundColor = .lightGray
        UIView.animate(withDuration: 0.5) {
            self.contentView.backgroundColor = .themeDarkGreen
        }
        delegate?.relapseTableViewCellDidSelect(self)
    }
    
    func set(with relapse: Relapse) {
        relapseTitleLabel.text = relapse.date.toString
    }
}
