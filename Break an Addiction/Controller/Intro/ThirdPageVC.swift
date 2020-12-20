//
//  ThirdPageVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class ThirdPageVC: UIViewController {
    
    // MARK: - Properties
    
    private let solutionsTagCaptionLabel: UILabel = {
        let label = Utilities().labelCaption(text: .solution)
        
        return label
    }()
    
    private let addReactionButton: UIButton = {
        let btn = UIButton()
        btn.setImageWithSize(size: 22, imgName: "plus")
        btn.tintColor = .themeOrange
        btn.addTarget(self, action: #selector(addReactionButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    private let solutionsTagView = TagView(frame: .zero, initializeWith: AddictionService.shared.getReactions())
    
    private let finishButton: UIButton = {
        let btn = Utilities().button(text: "Finish")
        btn.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        solutionsTagView.collectionView.flashScrollIndicators()
    }

    // MARK: - Selectors
    
    @objc func addReactionButtonPressed() {
        let alertController = Utilities().alertWithTextfields(caption: "Add new trigger", placeholders: [.trigger], completion: { [weak self] values in
            do {
                try AddictionService.shared.addReaction(name: values[0])
            } catch let error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            self?.solutionsTagView.collectionView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func finishButtonPressed() {
        let mainTabCtrl = MainTabController()
        mainTabCtrl.modalPresentationStyle = .fullScreen
        present(mainTabCtrl, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: [solutionsTagCaptionLabel, solutionsTagView])
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .equalCentering

        view.addSubview(stack)
        view.addSubview(finishButton)
        view.addSubview(addReactionButton)
        
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 120, paddingLeft: 32, paddingRight: 32)
        addReactionButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 20)
        finishButton.centerX(inView: view, topAnchor: addReactionButton.bottomAnchor, paddingTop: 20)
    }
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
    }
}

