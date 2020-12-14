//
//  SecondPageVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit
import TagListView

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
    
    let tagListView: TagListView = {
        let v = TagListView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0))
        v.layer.cornerRadius = 15
        v.cornerRadius = 7
        v.tagBackgroundColor = UIColor.themeOrange
        v.textFont = v.textFont.withSize(8)
        v.textColor = UIColor.white
        v.textFont = UIFont.boldSystemFont(ofSize: 20)
        v.alignment = .center // possible values are [.leading, .trailing, .left, .center, .right]
        v.marginY = 15
        v.marginX = 10
        
//        v.safeAreaInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        
        return v
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
        
//        tagListView.addTag("boredom at home")
//        tagListView.addTag("saw suggestive pic somewhere")
//        tagListView.addTag("wife yelled at me")
//        tagListView.addTag("saw alcohol in a supermarket")
//        tagListView.addTag("random intrusive thoughts")
//
//        view.addSubview(tagListView)
//        tagListView.center(inView: view)
        
//        tagListView.insertTag("This should be the second tag", at: 1)
        
//        view.addSubview(tagListView)
//        tagListView.center(inView: view)
        
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

