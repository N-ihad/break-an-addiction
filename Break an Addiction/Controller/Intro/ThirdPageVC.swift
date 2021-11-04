//
//  ThirdPageVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

private let reuseIdentifier = "TagCell"

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
    
    private let reactionsTagView = TagView(frame: .zero)
    
    private let finishButton: UIButton = {
        let btn = Utilities().button(text: "Finish")
        btn.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTagView()
        configureSubviews()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        reactionsTagView.collectionView.flashScrollIndicators()
    }

    // MARK: - Selectors
    
    @objc func addReactionButtonPressed() {
        let alertController = Utilities().alertWithTextfields(caption: "Add new reaction", placeholders: [.relapse], completion: { [weak self] values in
            do {
                try AddictionService.shared.addReaction(name: values[0])
            } catch {
                let error = error as! LocalizedDescriptionError
                let alert = Utilities().alertError(message: error.localizedDescription)
                self?.present(alert, animated: true, completion: nil)
            }
            self?.reactionsTagView.collectionView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func finishButtonPressed() {
        let mainTabCtrl = MainTabController()
        mainTabCtrl.modalPresentationStyle = .fullScreen
        present(mainTabCtrl, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureTagView() {
        reactionsTagView.collectionView.delegate = self
        reactionsTagView.collectionView.dataSource = self
        reactionsTagView.collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: [solutionsTagCaptionLabel, reactionsTagView])
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

extension ThirdPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AddictionService.shared.getReactions().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TagCollectionViewCell
        do {
            cell.textLabel.text = try AddictionService.shared.getReaction(at: indexPath.row).name
        } catch let error {
            print(error.localizedDescription)
        }
        
        return cell
    }
}

extension ThirdPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        do {
            let item = try AddictionService.shared.getReaction(at: indexPath.row).name
            var itemSize = item.size(withAttributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
            ])
            if itemSize.width > reactionsTagView.frame.width - 20 {
                itemSize.width = reactionsTagView.frame.width - 20
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

extension ThirdPageVC: UICollectionViewDelegate {
    
}

