//
//  RelapsesVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

final class InstructionsViewController: UIViewController {

    private let reuseIdentifier = "InstructionCell"

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
    }

    private func setup() {
        navigationItem.title = "Instructions"

        let addInstructionButton = UIButton()
        addInstructionButton.setImage(size: 18, imgName: "plus")
        addInstructionButton.addTarget(self, action: #selector(onAddNewInstruction), for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: addInstructionButton)
        navigationItem.rightBarButtonItem = barButton

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InstructionTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 10
        )
    }

    private func style() {
        view.backgroundColor = .themeDarkGreen
        tableView.backgroundColor = .themeDarkGreen
    }

    @objc private func onAddNewInstruction() {
        let alertController = Helper.makeAlertWithTextfields(
            caption: "Add new instruction",
            placeholders: [.trigger, .relapse]
        ) { [weak self] values in

            do {
                try AddictionManager.shared.addInstruction(triggerName: values[0], reactionName: values[1])
            } catch let error {
                let alert = Helper.makeErrorAlertController(message: error.localizedDescription)
                self?.present(alert, animated: true)
            }

            self?.tableView.reloadData()
        }

        present(alertController, animated: true)
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension InstructionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddictionManager.shared.instructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! InstructionTableViewCell
        let trigger = AddictionManager.shared.instructionTriggers[indexPath.row]
        cell.set(with: trigger.name, trigger.reaction!.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instructionDetailsViewController = InstructionDetailsViewController()
        navigationController?.pushViewController(instructionDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let reactionName = AddictionManager.shared.instructionTriggers[indexPath.row].reaction!.name
        return reactionName.height(withConstrainedWidth: (tableView.frame.width/2)-20, font: .boldSystemFont(ofSize: 17)) + 40
    }

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
