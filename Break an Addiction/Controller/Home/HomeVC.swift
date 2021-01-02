//
//  HomeVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    private let addictionNameLabel: UILabel = {
        let label = Utilities().label(text: "")
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private let abstainingCounterView: AbstainingCounterView = {
        let view = AbstainingCounterView()
        
        return view
    }()
    
    var counter: DateComponents {
        return Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: AddictionService.shared.getLastRelapseDate() ?? Date.yesterday, to: Date())
    }
    
    private let streaksView: StreaksView = {
        let view = StreaksView()
        
        return view
    }()
    
    private let relapseButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setDimensions(width: 56, height: 56)
        button.layer.cornerRadius = 56/2
        button.setImageWithSize(size: 22, imgName: "gobackward")
        button.tintColor = .black
        button.dropShadow()
        button.addTarget(self, action: #selector(relapseButtonPressed), for: .touchUpInside)
        
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runCounter()
        configureSubviews()
        configureNavBar()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    // MARK: - Selectors
    
    @objc func relapseButtonPressed() {
        let relapseNav = UINavigationController(rootViewController: RelapseVC())
        relapseNav.modalPresentationStyle = .popover
        present(relapseNav, animated: true, completion: nil)
    }
    
    @objc func settingsButtonPressed() {
        let settingsVC = SettingsVC()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func handleUpdateCounterLabel() {
        let counter = self.counter
        //let years = counter.year!
        let days = counter.day!
        let hours = counter.hour!
        let minutes = counter.minute!
        let seconds = counter.second!
        abstainingCounterView.counterLabel.text = String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
    }

    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        addictionNameLabel.text = AddictionService.shared.getAddictionName()
    }
    
    func configureSubviews() {
        let stack = UIStackView(arrangedSubviews: [addictionNameLabel, abstainingCounterView])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        view.addSubview(streaksView)
        streaksView.centerX(inView: view)
        streaksView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 100)
        
        view.addSubview(relapseButton)
        relapseButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 16)
    }
    
    func configureNavBar() {
        let button = UIButton()
        button.setImageWithSize(size: 18, imgName: "gear")
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func runCounter() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleUpdateCounterLabel), userInfo: nil, repeats: true)
    }
}

