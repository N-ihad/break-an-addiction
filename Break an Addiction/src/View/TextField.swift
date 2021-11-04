//
//  TextField.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

final class TextField: UITextField {

    private struct Default {
        static let inset: CGFloat = 10
    }

    private let lineView = UIView()
    
    init(frame: CGRect, placeholder: String) {
        super.init(frame: frame)

        setup(with: placeholder)
        layout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: Default.inset , dy: 0)
    }

    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: Default.inset , dy: 0)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: Default.inset, dy: 0)
    }

    private func setup(with placeholder: String) {
        self.placeholder = placeholder
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.themePlaceHolderColor]
        )
    }

    private func layout() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
    }

    private func style() {
        backgroundColor = .clear
        textColor = .white
        font = .textField

        lineView.backgroundColor = .white
        let metrics = ["width": NSNumber(value: 1)]
        let views = ["lineView": lineView]

        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[lineView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: metrics,
                views: views
            )
        )

        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[lineView(width)]|",
                options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: metrics,
                views: views
            )
        )
    }
}
