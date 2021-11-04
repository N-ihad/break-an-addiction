//
//  FirstPageViewController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    // MARK: - Properties
    private let motivationLabel: UILabel = {
        let lbl = Helper().labelCaption(text: .motivationalQuote)
        
        return lbl
    }()
    
    private let addictionNameTextField: TextField = {
        let tf = TextField(frame: CGRect(), placeholder: "Name your addiction, e.g. NoAlcohol")

        return tf
    }()
    
    private let nextButton: UIButton = {
        let btn = Helper().button(text: "Next")
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return btn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAddictionNameTextField()
        configureSubviews()
        configureUI()
    }

    // MARK: - Selectors
    @objc func nextButtonTapped() {
        if let controller = self.parent as? RootIntroPageViewController {
            controller.goToNextPage()
        }
    }
    
    // MARK: - Helpers
    
    func configureAddictionNameTextField() {
        addictionNameTextField.delegate = self
    }
    
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: [motivationLabel, addictionNameTextField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalCentering
        
        view.addSubview(stack)
        view.addSubview(nextButton)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 178, paddingLeft: 32, paddingRight: 32)
        nextButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 28)
    }
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
    }
}


extension FirstPageViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            AddictionService.shared.setAddictionName(name: text)
        }
    }
}

