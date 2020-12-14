//
//  SecondPageVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class SecondPageVC: UIViewController {
    
    // MARK: - Properties
    private let triggerCaptionLabel: UILabel = {
        let lbl = Utilities().labelCaptionForTextField(text: "Type trigger/event which led you to relapse", highlightAndUnderlineSubstring: "trigger/event")
        
        return lbl
    }()
    
    private let triggerTextField: UITextField = {
        let tf = TextField(frame: CGRect(), placeholder: "e.g. Seeing alcohol in supermarkets")
        
        return tf
    }()
    
    private let solutionCaptionLabel: UILabel = {
        let lbl = Utilities().labelCaptionForTextField(text: "Type what you're going to do if trigger/event occurs next time")
        
        return lbl
    }()
    
    private let triggerSolutionInputView: InputView = {
        let inputView = InputView(frame: CGRect())
        
        return inputView
    }()
    
    private let finishButton: UIButton = {
        let btn = Utilities().button(text: "Finish")
        
        return btn
    }()
    
    private let triggerTagView = TagView()
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
        view.addSubview(triggerTagView)
        triggerTagView.center(inView: view)
        triggerTagView.setDimensions(width: UIScreen.main.bounds.width - 40, height: 300)
        
//        let stack = UIStackView(arrangedSubviews: [triggerCaptionLabel, triggerTextField, solutionCaptionLabel, triggerSolutionInputView])
//        stack.axis = .vertical
//        stack.spacing = 20
//        stack.distribution = .equalCentering
//
//        view.addSubview(stack)
//        view.addSubview(finishButton)
//        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 178, paddingLeft: 32, paddingRight: 32)
//        finishButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 28)
    }
}

