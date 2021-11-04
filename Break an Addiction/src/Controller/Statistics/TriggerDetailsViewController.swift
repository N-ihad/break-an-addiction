//
//  TriggerDetailsVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class TriggerDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }
    
    private func setup() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(onCancel))
        navigationItem.rightBarButtonItem = cancelButton
    }

    private func style() {
        view.backgroundColor = .red
    }

    @objc private func onCancel() {
        dismiss(animated: true, completion: nil)
    }
}
