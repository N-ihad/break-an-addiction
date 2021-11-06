//
//  ThirdPageViewController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

final class ThirdPageViewController: UIViewController {
    
    private let reuseIdentifier = "TagCell"

    private let solutionsTagCaptionLabel = Helper.makeLabelCaption(text: .solution)
    private lazy var addReactionButton: UIButton = {
        let addReactionButton = UIButton()
        addReactionButton.setImage(size: 22, imgName: "plus")
        addReactionButton.tintColor = .themeOrange
        addReactionButton.addTarget(self, action: #selector(onAddReaction), for: .touchUpInside)
        return addReactionButton
    }()
    private let reactionsTagsView = TagsView()
    private lazy var finishButton: UIButton = {
        let finishButton = Helper.makeButton(text: "Finish")
        finishButton.addTarget(self, action: #selector(onFinish), for: .touchUpInside)
        return finishButton
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        reactionsTagsView.collectionView.flashScrollIndicators()
    }

    private func setup() {
        reactionsTagsView.collectionView.delegate = self
        reactionsTagsView.collectionView.dataSource = self
        reactionsTagsView.collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func layout() {
        let stack = UIStackView(arrangedSubviews: [solutionsTagCaptionLabel, reactionsTagsView])
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

        view.addSubview(addReactionButton)
        addReactionButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 20)

        view.addSubview(finishButton)
        finishButton.centerX(inView: view, topAnchor: addReactionButton.bottomAnchor, paddingTop: 20)
    }
    
    private func style() {
        view.backgroundColor = .themeDarkGreen
    }

    @objc private func onAddReaction() {
        let alertController = Helper.makeAlertWithTextfields(
            caption: "Add new reaction",
            placeholders: [.relapse]
        ) { [weak self] values in

            do {
                try AddictionManager.shared.addReaction(name: values[0])
            } catch let error {
                let alert = Helper.makeErrorAlertController(message: error.localizedDescription)
                self?.present(alert, animated: true)
            }

            self?.reactionsTagsView.collectionView.reloadData()
        }

        present(alertController, animated: true)
    }

    @objc private func onFinish() {
        let mainTabController = TabBarController()
        mainTabController.modalPresentationStyle = .fullScreen
        present(mainTabController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension ThirdPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AddictionManager.shared.reactions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TagsCollectionViewCell

        do {
            cell.textLabel.text = try AddictionManager.shared.reaction(at: indexPath.row).name
        } catch let error {
            print(error.localizedDescription)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ThirdPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        do {
            let reactionName = try AddictionManager.shared.reaction(at: indexPath.row).name
            var reactionNameSize = reactionName.size(withAttributes: [
                .font: UIFont.boldSystemFont(ofSize: 16)
            ])

            if reactionNameSize.width > reactionsTagsView.frame.width - 20 {
                reactionNameSize.width = reactionsTagsView.frame.width - 20
            }

            return CGSize(width: reactionNameSize.width + 18, height: reactionNameSize.height + 6)
        } catch let error {
            print(error.localizedDescription)
        }

        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
