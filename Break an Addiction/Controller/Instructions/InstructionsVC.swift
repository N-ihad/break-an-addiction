//
//  RelapsesVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

private let reuseIdentifier = "InstructionCell"

private var instructions = [String : String]()

class InstructionsVC: UIViewController {
    
    // MARK: - Properties
    
    let tableView = UITableView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func plusRightBarButtonPressed() {
        let alertController = Utilities().alertWithTextfields(caption: "Add new instruction", placeholders: [.trigger, .relapse], completion: { [weak self] values in
            // for awhile
            instructions[values[0]] = values[1]
//            triggers.insert(values[0], at: 0)
//            solutions.insert(values[1], at: 0)
            self?.tableView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
        configureTableView()
        configureNavBar()
        setUpDataForTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(InstructionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
//        tableView.pinTo(view)
        tableView.backgroundColor = .themeDarkGreen
    }
    
    func configureNavBar() {
        navigationItem.title = "Instructions"
        let addInstructionButton = UIButton()
        addInstructionButton.setImageWithSize(size: 18, imgName: "plus")
        addInstructionButton.addTarget(self, action: #selector(plusRightBarButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: addInstructionButton)
        navigationItem.rightBarButtonItem = barButton
//        navigationController?.navigationBar.addSubview(addInstructionButton)
//        addInstructionButton.anchor(top: navigationController?.navigationBar.topAnchor, right: navigationController?.navigationBar.rightAnchor, paddingTop: 50, paddingRight: 20)
//        navigationItem.rightBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 10, vertical: 60), for: UIBarMetrics.default)
    }
    
    func setUpDataForTableView() {
        for (trigger, solution) in zip(AddictionService.shared.getTriggersInString(), AddictionService.shared.getTriggerReactionsInString()) {
            instructions[trigger] = solution
        }
    }
}


extension InstructionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! InstructionCell
        cell.set(trigger: Array(instructions)[indexPath.row].key, solution: Array(instructions)[indexPath.row].value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instructionDetailsVC = InstructionDetailsVC()
        navigationController?.pushViewController(instructionDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Array(instructions)[indexPath.row].value.height(withConstrainedWidth: (tableView.frame.width/2)-20, font: UIFont.boldSystemFont(ofSize: 17)) + 40
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete && !searchController.searchBar.isFirstResponder {
//            self.groups.remove(at: indexPath.row)
//            self.filteredData.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
}
