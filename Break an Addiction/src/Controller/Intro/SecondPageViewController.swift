//
//  SecondPageViewController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

final class SecondPageViewController: UIViewController {

    private let identifier = "TagCell"
    private let triggersTagCaptionLabel = Helper.makeLabelCaption(text: .trigger, highlightAndUnderlineSubstring: "trigger/event")

    private lazy var addTriggerButton: UIButton = {
        let addTriggerButton = UIButton()
        addTriggerButton.setImage(size: 22, imgName: "plus")
        addTriggerButton.tintColor = .themeOrange
        addTriggerButton.addTarget(self, action: #selector(onAddTrigger), for: .touchUpInside)
        return addTriggerButton
    }()
    
    private let presentNextPageButton: UIButton = {
        let presentNextPageButton = Helper.makeButton(text: "Next")
        presentNextPageButton.addTarget(self, action: #selector(onNextPage), for: .touchUpInside)
        return presentNextPageButton
    }()

    private let triggersTagView = TagsView(frame: .zero)

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        style()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        triggersTagView.collectionView.flashScrollIndicators()
    }

    private func setup() {
        triggersTagView.collectionView.delegate = self
        triggersTagView.collectionView.dataSource = self
        triggersTagView.collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
    }

    private func layout() {
        let stack = UIStackView(arrangedSubviews: [triggersTagCaptionLabel, triggersTagView])
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .equalCentering

        view.addSubview(stack)
        stack.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 120,
            paddingLeft: 32,
            paddingRight: 32
        )

        view.addSubview(addTriggerButton)
        addTriggerButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 20)

        view.addSubview(presentNextPageButton)
        presentNextPageButton.centerX(inView: view, topAnchor: addTriggerButton.bottomAnchor, paddingTop: 20)
    }
    
    private func style() {
        view.backgroundColor = .themeDarkGreen
    }

    @objc private func onAddTrigger() {
        let alertController = Helper.makeAlertWithTextfields(
            caption: "Add new trigger",
            placeholders: [.trigger]
        ) { [weak self] values in

            do {
                try AddictionManager.shared.addTrigger(name: values[0])
            } catch let error {
                let error = error as! LocalizedDescriptionError
                let alert = Helper.makeErrorAlertController(message: error.localizedDescription)
                self?.present(alert, animated: true)
            }
            self?.triggersTagView.collectionView.reloadData()
        }
        present(alertController, animated: true)
    }

    @objc private func onNextPage() {
        if let controller = parent as? RootIntroPageViewController {
            controller.presentNextPage()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SecondPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AddictionManager.shared.triggers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TagsCollectionViewCell
        do {
            cell.textLabel.text = try AddictionManager.shared.trigger(at: indexPath.row).name
        } catch let error {
            print(error.localizedDescription)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SecondPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        do {
            let item = try AddictionManager.shared.trigger(at: indexPath.row).name
            var itemSize = item.size(withAttributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
            if itemSize.width > triggersTagView.frame.width - 20 {
                itemSize.width = triggersTagView.frame.width - 20
            }
            return CGSize(width: itemSize.width + 18, height: itemSize.height + 6)
        } catch let error {
            print(error.localizedDescription)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
