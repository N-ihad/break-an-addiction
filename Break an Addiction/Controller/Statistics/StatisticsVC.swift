//
//  TriggersVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

private let reuseIdentifierRelapse = "RelapseCell"
private let reuseIdentifierTrigger = "TriggerCell"

protocol TableViewSwipeableProtocol: class {
    func updateFilterView(_ tableView: UITableView, direction: UICollectionView.ScrollPosition)
}

class StatisticsVC: UIViewController {
    // MARK: - Properties
    
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
    
    private let filterView: DataFilterView = {
        let filterView = DataFilterView()
        
        return filterView
    }()
    
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

    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.delegate = self
        
        configureUI()
        configureGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.relapsesTableView.reloadData()
        self.triggersTableView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func handleLeftSwipe() {
        let selectedIndexPath = IndexPath(row: 1, section: 0)
        filterView.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .right)
        filterView(filterView, didSelect: selectedIndexPath)
        
    }
    
    @objc func handleRightSwipe() {
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        filterView.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        filterView(filterView, didSelect: selectedIndexPath)
    }

    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
        configureNavBar()
        configureTableView()
        configureSubviews()
    }
    
    func configureGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
        swipeLeft.direction = .left
        self.relapsesTableView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        swipeRight.direction = .right
        self.triggersTableView.addGestureRecognizer(swipeRight)
    }
    
    func configureNavBar() {
        navigationItem.title = "Statistics"
//        navigationItem.largeTitleDisplayMode = .never // if you wanted subsequent view controllers to never use large titles
    }
    
    func configureTableView() {
        relapsesTableView.delegate = self
        relapsesTableView.dataSource = self
        relapsesTableView.register(RelapseCell.self, forCellReuseIdentifier: reuseIdentifierRelapse)
        triggersTableView.delegate = self
        triggersTableView.dataSource = self
        triggersTableView.register(TriggerCell.self, forCellReuseIdentifier: reuseIdentifierTrigger)
    }
    
    func configureSubviews() {
        view.addSubview(briefTriggersAndRelapsesStats)
        briefTriggersAndRelapsesStats.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        view.addSubview(filterView)
        filterView.centerX(inView: view, topAnchor: briefTriggersAndRelapsesStats.bottomAnchor, paddingTop: 15)
        filterView.setDimensions(width: view.frame.width, height: 50)
        
        view.addSubview(underlineView)
        underlineView.anchor(top: filterView.bottomAnchor, left: view.leftAnchor, width: view.frame.width / 2, height: 2)
        
        view.addSubview(relapsesTableView)
        relapsesTableView.anchor(top: underlineView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        view.addSubview(triggersTableView)
        triggersTableView.anchor(top: underlineView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
}

extension StatisticsVC: DataFilterViewDelegate {
    func filterView(_ view: DataFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? FilteredDataCell else {return}
        guard self.underlineView.frame.origin.x != cell.frame.origin.x else {return}
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.15) {
            self.underlineView.frame.origin.x = xPosition
        }
        
        relapsesTableView.isHidden = !relapsesTableView.isHidden
        triggersTableView.isHidden = !triggersTableView.isHidden
    }
}

extension StatisticsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == relapsesTableView ? AddictionService.shared.getRelapses().count : AddictionService.shared.getOccurredTriggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == relapsesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierRelapse) as! RelapseCell
            cell.set(relapse: AddictionService.shared.getRelapses()[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTrigger) as! TriggerCell
            cell.set(trigger: AddictionService.shared.getOccurredTriggers[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nav = (tableView == relapsesTableView) ?
//            UINavigationController(rootViewController: RelapseDetailsVC()) :
//            UINavigationController(rootViewController: TriggerDetailsVC())
//
//        nav.modalPresentationStyle = .popover
//        present(nav, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == triggersTableView {
            return AddictionService.shared.getTriggers()[indexPath.row].name.height(withConstrainedWidth: (tableView.frame.width/2)-20, font: UIFont.boldSystemFont(ofSize: 17)) + 40
        }
        return 60
    }
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete && !searchController.searchBar.isFirstResponder {
//            self.groups.remove(at: indexPath.row)
//            self.filteredData.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
}

extension StatisticsVC: RelapseCellDelegate, TriggerCellDelegate {
    func handleCellPressed(_ cell: RelapseCell) {
        let relapseNav = UINavigationController(rootViewController: RelapseDetailsVC())
        relapseNav.modalPresentationStyle = .popover
        present(relapseNav, animated: true, completion: nil)
    }
    
    func handleCellPressed(_ cell: TriggerCell) {
        let triggerNav = UINavigationController(rootViewController: TriggerDetailsVC())
        triggerNav.modalPresentationStyle = .popover
        present(triggerNav, animated: true, completion: nil)
    }
    
    
}

