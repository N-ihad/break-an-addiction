//
//  HomeVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

final class HomeViewController: UIViewController {

    private let addictionNameLabel: UILabel = {
        let label = Utilities().label(text: "")
        label.font = .addictionName
        return label
    }()
    
    private let abstainingCounterView = AbstainingCounterView()
    private let streaksView = StreaksView()
    
    private lazy var relapseButton: UIButton = {
        let relapseButton = UIButton(type: .system)
        relapseButton.backgroundColor = .white
        relapseButton.setDimensions(width: 56, height: 56)
        relapseButton.layer.cornerRadius = 56 / 2
        relapseButton.setImageWithSize(size: 22, imgName: "gobackward")
        relapseButton.tintColor = .black
        relapseButton.dropShadow()
        relapseButton.addTarget(self, action: #selector(relapseButtonPressed), for: .touchUpInside)
        return relapseButton
    }()

    var counter: DateComponents {
        Calendar.current.dateComponents(
            [.year, .day, .hour, .minute, .second],
            from: AddictionService.shared.getLastRelapseDate() ?? Date.yesterday, to: Date()
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
        runCounter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setup() {
        addictionNameLabel.text = AddictionService.shared.getAddictionName()

        let button = UIButton()
        button.setImageWithSize(size: 18, imgName: "gear")
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func layout() {
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

    private func style() {
        view.backgroundColor = .themeDarkGreen
    }
    
    private func runCounter() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleUpdateCounterLabel), userInfo: nil, repeats: true)
    }

    @objc private func relapseButtonPressed() {
        let relapseNav = UINavigationController(rootViewController: RelapseVC())
        relapseNav.modalPresentationStyle = .popover
        present(relapseNav, animated: true, completion: nil)
    }

    @objc private func settingsButtonPressed() {
        let settingsVC = SettingsVC()
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc private func handleUpdateCounterLabel() {
        let counter = counter
        //let years = counter.year!
        let days = counter.day!
        let hours = counter.hour!
        let minutes = counter.minute!
        let seconds = counter.second!
        abstainingCounterView.set(with: String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds))
    }
}

