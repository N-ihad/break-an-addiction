//
//  SecondPageVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

private let reuseIdentifier = "TagCell"

class SecondPageVC: UIViewController {
    
    // MARK: - Properties
    
    private let triggersTagCaptionLabel: UILabel = {
        let lbl = Utilities().labelCaption(text: .trigger, highlightAndUnderlineSubstring: "trigger/event")
        
        return lbl
    }()
    
    private let addTriggerButton: UIButton = {
        let btn = UIButton()
        btn.setImageWithSize(size: 22, imgName: "plus")
        btn.tintColor = .themeOrange
        btn.addTarget(self, action: #selector(addTriggerButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    private let nextPageButton: UIButton = {
        let btn = Utilities().button(text: "Next")
        btn.addTarget(self, action: #selector(nextPageButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    private let triggersTagView = TagView(frame: .zero, initializeWith: AddictionService.shared.getTriggers())
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        triggersTagView.collectionView.flashScrollIndicators()
    }

    // MARK: - Selectors
    
    @objc func addTriggerButtonPressed() {
        let alertController = Utilities().alertWithTextfields(caption: "Add new trigger", placeholders: [.trigger], completion: { [weak self] values in
            do {
                try AddictionService.shared.addTrigger(name: values[0])
            } catch let error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            self?.triggersTagView.collectionView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func nextPageButtonPressed() {
        if let controller = self.parent as? RootIntroPageVC {
            controller.goToNextPage()
        }
    }
    
    // MARK: - Helpers
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: [triggersTagCaptionLabel, triggersTagView])
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .equalCentering

        view.addSubview(stack)

        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 120, paddingLeft: 32, paddingRight: 32)

        view.addSubview(nextPageButton)
        view.addSubview(addTriggerButton)
        addTriggerButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 20)
        nextPageButton.centerX(inView: view, topAnchor: addTriggerButton.bottomAnchor, paddingTop: 20)
    }
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
//            self?.triggersTagView.collectionView.flashScrollIndicators()
//        }
//        UIView.animate
        
//        UIView.animate(withDuration: {$duration},
//              animations: { /* Animation Here */ },
//              completion: { _ in self.performSegue(withIdentifier: "segueIdentifierHere", sender: nil) }

    }
}

