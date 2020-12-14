//
//  FirstPageVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class FirstPageVC: UIViewController {
    
    // MARK: - Properties
    private let motivationLabel: UILabel = {
        let lbl = Utilities().labelCaptionForTextField(text: "“The resistance that you fight physically in the gym and the resistance that you fight in life can only build a strong character.” Arnold Schwarzenegger")
        
        return lbl
    }()
    
    private let habitNameTextField: TextField = {
        let tf = TextField(frame: CGRect(), placeholder: "Name your addiction, e.g. NoAlcohol")

        return tf
    }()
    
    private let nextButton: UIButton = {
        let btn = Utilities().button(text: "Next")
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Selectors
    @objc func nextButtonTapped() {
        if let controller = self.parent as? RootIntroPageVC {
            controller.goToNextPage()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
        let stack = UIStackView(arrangedSubviews: [motivationLabel, habitNameTextField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalCentering
        
        view.addSubview(stack)
        view.addSubview(nextButton)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 178, paddingLeft: 32, paddingRight: 32)
        nextButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 28)

    }
}

