//
//  TriggerDetailsVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

class TriggerDetailsVC: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .red
        
        configureNavBar()
    }
    
    func configureNavBar() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = cancelItem
    }
    
}
