//
//  FirstPageViewController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

final class FirstPageViewController: UIViewController {

    private let motivationLabel = Helper.makeLabelCaption(text: .motivationalQuote)
    private let addictionNameTextField = TextField(frame: .zero, placeholder: "Name your addiction, e.g. NoAlcohol")

    private lazy var nextButton: UIButton = {
        let nextButton = Helper.makeButton(text: "Next")
        nextButton.addTarget(self, action: #selector(onNextPage), for: .touchUpInside)
        return nextButton
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
    }

    private func setup() {
        addictionNameTextField.delegate = self
    }

    private func layout() {
        let stack = UIStackView(arrangedSubviews: [motivationLabel, addictionNameTextField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalCentering
        
        view.addSubview(stack)
        view.addSubview(nextButton)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 178, paddingLeft: 32, paddingRight: 32)
        nextButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 28)
    }

    private func style() {
        view.backgroundColor = .themeDarkGreen
    }

    @objc private func onNextPage() {
        if let controller = parent as? RootIntroPageViewController {
            controller.presentNextPage()
        }
    }
}

// MARK: - UITextFieldDelegate
extension FirstPageViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
           !text.isEmpty {
            AddictionManager.shared.setAddictionName(name: text)
        }
    }
}

