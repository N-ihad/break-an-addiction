//
//  RelapseViewController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/15/20.
//

import UIKit

final class RelapseViewController: UIViewController {
    
    private let triggerReuseIdentifier = "TriggerCell"
    private let reactionReuseIdentifier = "ReactionCell"

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height + 700
        )
        return scrollView
    }()
    
    private let relapseDatePicker: UIDatePicker = {
        let relapseDatePicker = UIDatePicker()
        relapseDatePicker.preferredDatePickerStyle = .wheels
        relapseDatePicker.tintColor = .white
        relapseDatePicker.setValue(UIColor.white, forKey: "textColor")
        relapseDatePicker.setValue(false, forKey: "highlightsToday")
        relapseDatePicker.addTarget(self, action: #selector(onRelapseDatePickerChange), for: UIControl.Event.valueChanged)
        
        return relapseDatePicker
    }()
    
    private let triggersTagView = TagsView()
    private let triggersTagViewCaptionLabel = Helper.makeLabelCaption(text: .trigger, highlightAndUnderlineSubstring: "trigger")
    
    private let reactionsTagView = TagsView()
    private let reactionsTagViewCaptionLabel = Helper.makeLabelCaption(text: .solution)

    private var relapseDate: Date = Date()
    private var trigger: Trigger?
    private var reaction: Reaction?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        style()
    }

    private func setup() {
        triggersTagView.collectionView.delegate = self
        triggersTagView.collectionView.dataSource = self
        triggersTagView.collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: triggerReuseIdentifier)
        
        reactionsTagView.collectionView.delegate = self
        reactionsTagView.collectionView.dataSource = self
        reactionsTagView.collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: reactionReuseIdentifier)

        let cancelItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(onCancel))
        let resetItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(onReset))
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = resetItem
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.pinTo(view)
        
        let stack = UIStackView(
            arrangedSubviews: [
                relapseDatePicker,
                triggersTagViewCaptionLabel,
                triggersTagView,
                reactionsTagViewCaptionLabel,
                reactionsTagView
            ]
        )
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalCentering
        
        scrollView.addSubview(stack)
        stack.centerX(inView: scrollView)
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: view.frame.width-64).isActive = true
    }

    private func style() {
        view.backgroundColor = .themeDarkGreen
    }

    @objc private func onCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func onRelapseDatePickerChange(sender: UIDatePicker) {
        relapseDate = sender.date
    }

    @objc private func onReset() {
        trigger?.count += 1
        AddictionManager.shared.addRelapse(date: relapseDate, instruction: nil, trigger: trigger)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension RelapseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == triggersTagView.collectionView {
            return AddictionManager.shared.triggers.count
        } else {
            return AddictionManager.shared.reactions.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == triggersTagView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: triggerReuseIdentifier, for: indexPath) as! TagsCollectionViewCell
            cell.delegate = self
            do {
                cell.textLabel.text = try AddictionManager.shared.trigger(at: indexPath.row).name
            } catch let error {
                print(error.localizedDescription)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reactionReuseIdentifier, for: indexPath) as! TagsCollectionViewCell
            cell.delegate = self
            do {
                cell.textLabel.text = try AddictionManager.shared.reaction(at: indexPath.row).name
            } catch let error {
                print(error.localizedDescription)
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RelapseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        do {
            let text = try AddictionManager.shared.trigger(at: indexPath.row).name
            return collectionView.cellSize(for: text)
        } catch let error {
            print(error.localizedDescription)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: - TagsCollectionViewCellDelegate
extension RelapseViewController: TagsCollectionViewCellDelegate {
    func tagsCollectionViewCellDidReceiveTap(_ cell: TagsCollectionViewCell) {
        trigger = AddictionManager.shared.trigger(with: cell.textLabel.text!)
    }
}
