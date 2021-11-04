//
//  HomeVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

final class HomeViewController: UIViewController {

    private let addictionNameLabel: UILabel = {
        let label = Helper().label(text: "")
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
        relapseButton.setImage(size: 22, imgName: "gobackward")
        relapseButton.tintColor = .black
        relapseButton.dropShadow()
        relapseButton.addTarget(self, action: #selector(onRelapse), for: .touchUpInside)
        return relapseButton
    }()

    var counter: DateComponents {
        Calendar.current.dateComponents(
            [.year, .day, .hour, .minute, .second],
            from: AddictionService.shared.lastRelapseDate ?? Date.yesterday, to: Date()
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
        runCounter()
    }

    private func setup() {
        addictionNameLabel.text = AddictionService.shared.addictionName

        let button = UIButton()
        button.setImage(size: 18, imgName: "gear")
        button.addTarget(self, action: #selector(onSettings), for: .touchUpInside)
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

    @objc private func onRelapse() {
        let relapseNavigationController = UINavigationController(rootViewController: RelapseViewController())
        relapseNavigationController.modalPresentationStyle = .popover
        present(relapseNavigationController, animated: true, completion: nil)
    }

    @objc private func onSettings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc private func onUpdateCounter() {
        let counter = counter
        //let years = counter.year!
        let days = counter.day!
        let hours = counter.hour!
        let minutes = counter.minute!
        let seconds = counter.second!
        abstainingCounterView.set(with: String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds))
    }

    private func runCounter() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onUpdateCounter), userInfo: nil, repeats: true)
    }
}

