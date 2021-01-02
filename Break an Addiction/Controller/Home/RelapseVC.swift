//
//  RelapseVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/15/20.
//

import UIKit
private let triggerReuseIdentifier = "TriggerCell"
private let reactionReuseIdentifier = "ReactionCell"

class RelapseVC: UIViewController {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+700)
        
        return scrollView
    }()
    
    private let whenRelapseHappenedDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .white
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        datePicker.addTarget(self, action: #selector(handleDatePickerChangedValue), for: UIControl.Event.valueChanged)
        
        return datePicker
    }()
    
    private let triggersTagView = TagView(frame: .zero)
    private let triggersTagViewCaptionLabel = Utilities().labelCaption(text: .trigger, highlightAndUnderlineSubstring: "trigger")
    
    private let reactionsTagView = TagView()
    private let reactionsTagViewCaptionLabel = Utilities().labelCaption(text: .solution)
    
    private var relapseDate: Date = Date()
    private var trigger: Trigger?
    private var reaction: Reaction?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTagViews()
        configureSubviews()
        configureNavBar()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDatePickerChangedValue(sender: UIDatePicker) {
        relapseDate = sender.date
    }
    
    @objc func resetButtonPressed() {
        trigger?.count += 1
        AddictionService.shared.addRelapse(date: relapseDate, instruction: nil, trigger: trigger)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureTagViews() {
        triggersTagView.collectionView.delegate = self
        triggersTagView.collectionView.dataSource = self
        triggersTagView.collectionView.register(TagCell.self, forCellWithReuseIdentifier: triggerReuseIdentifier)
        
        reactionsTagView.collectionView.delegate = self
        reactionsTagView.collectionView.dataSource = self
        reactionsTagView.collectionView.register(TagCell.self, forCellWithReuseIdentifier: reactionReuseIdentifier)
    }
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
    }
    
    func configureSubviews() {
        self.view.addSubview(scrollView)
        scrollView.pinTo(view)
        
//        scrollView.backgroundColor = .red
//        scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-20).isActive = true
        
        
        let stack = UIStackView(arrangedSubviews: [whenRelapseHappenedDatePicker, triggersTagViewCaptionLabel, triggersTagView, reactionsTagViewCaptionLabel, reactionsTagView])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalCentering
        
        scrollView.addSubview(stack)
        stack.centerX(inView: scrollView)
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: view.frame.width-64).isActive = true
    }
    
    func configureNavBar() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
        let resetItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetButtonPressed))
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = resetItem
    }
    
}

extension RelapseVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == triggersTagView.collectionView ?
            AddictionService.shared.getTriggers().count : AddictionService.shared.getReactions().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == triggersTagView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: triggerReuseIdentifier, for: indexPath) as! TagCell
            cell.delegate = self
            do {
                cell.titleLabel.text = try AddictionService.shared.getTrigger(at: indexPath.row).name
            } catch let error {
                print(error.localizedDescription)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reactionReuseIdentifier, for: indexPath) as! TagCell
            cell.delegate = self
            do {
                cell.titleLabel.text = try AddictionService.shared.getReaction(at: indexPath.row).name
            } catch let error {
                print(error.localizedDescription)
            }
            return cell
        }
    }
}

extension RelapseVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        do {
            let text = try AddictionService.shared.getTrigger(at: indexPath.row).name
            return collectionView.calculateCellSizeBasedOnText(text: text)
        } catch let error {
            print(error.localizedDescription)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension RelapseVC: UICollectionViewDelegate {
    
}

extension RelapseVC: TagCellDelegate {
    func handleTagPressed(_ cell: TagCell) {
        trigger = AddictionService.shared.getTrigger(with: cell.titleLabel.text!)
    }
}
