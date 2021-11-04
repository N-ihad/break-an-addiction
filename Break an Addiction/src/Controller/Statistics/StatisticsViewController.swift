//
//  TriggersVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

final class StatisticsViewController: UIViewController {

    private let reuseIdentifierRelapse = "RelapseCell"
    private let reuseIdentifierTrigger = "TriggerCell"
    
    private let briefTriggersAndRelapsesStats: UIView = {
        let view = UIView()
        view.setDimensions(width: UIScreen.main.bounds.width - 20, height: 200)
        view.backgroundColor = .themeLightGreen
        
        let label = UILabel()
        label.text = "In Maintenance"
        
        view.addSubview(label)
        label.center(inView: view)
        
        return view
    }()
    
    private let filterView = DataFilterView()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .themeOrange
        
        return view
    }()
    
    private let relapsesTableView: UITableView = {
        let relapsesTableView = UITableView()
        relapsesTableView.isHidden = false
        relapsesTableView.backgroundColor = .themeDarkGreen
        
        return relapsesTableView
    }()
    
    private let triggersTableView: UITableView = {
        let triggersTableView = UITableView()
        triggersTableView.isHidden = true
        triggersTableView.backgroundColor = .themeDarkGreen
        
        return triggersTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.delegate = self
        
        setup()
        layout()
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        relapsesTableView.reloadData()
        triggersTableView.reloadData()
    }
    
    private func setup() {
        navigationItem.title = "Statistics"

        relapsesTableView.delegate = self
        relapsesTableView.dataSource = self
        relapsesTableView.register(RelapseTableViewCell.self, forCellReuseIdentifier: reuseIdentifierRelapse)

        triggersTableView.delegate = self
        triggersTableView.dataSource = self
        triggersTableView.register(TriggerTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTrigger)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onLeftSwipe))
        swipeLeft.direction = .left
        relapsesTableView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onRightSwipe))
        swipeRight.direction = .right
        triggersTableView.addGestureRecognizer(swipeRight)
    }

    private func layout() {
        view.addSubview(briefTriggersAndRelapsesStats)
        briefTriggersAndRelapsesStats.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)

        view.addSubview(filterView)
        filterView.centerX(inView: view, topAnchor: briefTriggersAndRelapsesStats.bottomAnchor, paddingTop: 15)
        filterView.setDimensions(width: view.frame.width, height: 50)

        view.addSubview(underlineView)
        underlineView.anchor(top: filterView.bottomAnchor, left: view.leftAnchor, width: view.frame.width / 2, height: 2)

        view.addSubview(relapsesTableView)
        relapsesTableView.anchor(top: underlineView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)

        view.addSubview(triggersTableView)
        triggersTableView.anchor(top: underlineView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }

    private func style() {
        view.backgroundColor = .themeDarkGreen
    }

    @objc private func onLeftSwipe() {
        let selectedIndexPath = IndexPath(row: 1, section: 0)
        filterView.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .right)
        dataFilterView(filterView, didSelect: selectedIndexPath)

    }

    @objc private func onRightSwipe() {
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        filterView.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        dataFilterView(filterView, didSelect: selectedIndexPath)
    }
}

// MARK: - DataFilterViewDelegate
extension StatisticsViewController: DataFilterViewDelegate {
    func dataFilterView(_ view: DataFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? DataFilterCell,
              underlineView.frame.origin.x != cell.frame.origin.x else {
            return
        }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.15) {
            self.underlineView.frame.origin.x = xPosition
        }
        
        relapsesTableView.isHidden = !relapsesTableView.isHidden
        triggersTableView.isHidden = !triggersTableView.isHidden
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == relapsesTableView {
            return AddictionService.shared.relapses.count
        } else {
            return AddictionService.shared.occurredTriggers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == relapsesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierRelapse) as! RelapseTableViewCell
            cell.set(with: AddictionService.shared.relapses[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTrigger) as! TriggerTableViewCell
            cell.set(with: AddictionService.shared.occurredTriggers[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == triggersTableView {
            let triggerName = AddictionService.shared.triggers[indexPath.row].name
            return triggerName.height(withConstrainedWidth: (tableView.frame.width/2)-20, font: .boldSystemFont(ofSize: 17)) + 40
        }
        return 60
    }
}

// MARK: - RelapseTableViewCellDelegate, TriggerTableViewCellDelegate
extension StatisticsViewController: RelapseTableViewCellDelegate, TriggerTableViewCellDelegate {
    func relapseTableViewCellDidReceiveTap(_ cell: RelapseTableViewCell) {
        let relapseNavigationController = UINavigationController(rootViewController: RelapseDetailsViewController())
        relapseNavigationController.modalPresentationStyle = .popover
        present(relapseNavigationController, animated: true)
    }
    
    func triggerTableViewCellDidReceiveTap(_ cell: TriggerTableViewCell) {
        let triggerNavigationController = UINavigationController(rootViewController: TriggerDetailsViewController())
        triggerNavigationController.modalPresentationStyle = .popover
        present(triggerNavigationController, animated: true)
    }
}
