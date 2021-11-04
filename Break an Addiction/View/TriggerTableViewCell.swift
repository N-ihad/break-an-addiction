//
//  TriggerCell.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//


import UIKit

protocol TriggerTableViewCellDelegate: AnyObject {
    func triggerTableViewCellDidSelect(_ cell: TriggerTableViewCell)
}

final class TriggerTableViewCell: UITableViewCell {

    var delegate: TriggerTableViewCellDelegate?
    
    private let triggerTitleLabel: UILabel = {
        let triggerTitleLabel = UILabel()
        triggerTitleLabel.textColor = .white
        triggerTitleLabel.font = .instructionCell
        return triggerTitleLabel
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
        contentView.addSubview(triggerTitleLabel)
        triggerTitleLabel.centerY(inView: contentView, leftAnchor: leftAnchor, paddingLeft: 14)
    }

    private func style() {
        contentView.backgroundColor = .themeDarkGreen
    }

    @objc private func cellTapped() {
        contentView.backgroundColor = .lightGray
        UIView.animate(withDuration: 0.5) {
            self.contentView.backgroundColor = .themeDarkGreen
        }
        delegate?.triggerTableViewCellDidSelect(self)
    }
    
    func set(with trigger: Trigger) {
        triggerTitleLabel.text = trigger.name
    }
}
