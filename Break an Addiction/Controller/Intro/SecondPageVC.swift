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
    
    private let triggersTagView = TagView(frame: .zero)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTagView()
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
                let error = error as! LocalizedDescriptionError
                let alert = Utilities().alertError(message: error.localizedDescription)
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
    
    func configureTagView() {
        triggersTagView.collectionView.delegate = self
        triggersTagView.collectionView.dataSource = self
        triggersTagView.collectionView.register(TagCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
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
    }
}


extension SecondPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AddictionService.shared.getTriggers().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TagCell
        do {
            cell.titleLabel.text = try AddictionService.shared.getTrigger(at: indexPath.row).name
        } catch let error {
            print(error.localizedDescription)
        }
        
        return cell
    }
}

extension SecondPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        do {
            let item = try AddictionService.shared.getTrigger(at: indexPath.row).name
            var itemSize = item.size(withAttributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
            ])
            if itemSize.width > triggersTagView.frame.width - 20 {
                itemSize.width = triggersTagView.frame.width - 20
            }
            return CGSize(width: itemSize.width + 18, height: itemSize.height + 6)
        } catch let error {
            print(error.localizedDescription)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension SecondPageVC: UICollectionViewDelegate {
    
}
