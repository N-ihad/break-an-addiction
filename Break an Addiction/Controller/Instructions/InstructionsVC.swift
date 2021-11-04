//
//  RelapsesVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

private let reuseIdentifier = "InstructionCell"

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
            do {
                try AddictionService.shared.addInstruction(triggerName: values[0], reactionName: values[1])
            } catch {
                let error = error as! LocalizedDescriptionError
                let alert = Utilities().alertError(message: error.localizedDescription)
                self?.present(alert, animated: true, completion: nil)
            }
            self?.tableView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
        configureTableView()
        configureNavBar()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(InstructionTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
    }
}


extension InstructionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddictionService.shared.getInstructions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! InstructionTableViewCell
        let trigger = AddictionService.shared.instructionTriggers[indexPath.row]
        cell.set(with: trigger.name, trigger.reaction!.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instructionDetailsVC = InstructionDetailsVC()
        navigationController?.pushViewController(instructionDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddictionService.shared.instructionTriggers[indexPath.row].reaction!.name.height(withConstrainedWidth: (tableView.frame.width/2)-20, font: UIFont.boldSystemFont(ofSize: 17)) + 40
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
