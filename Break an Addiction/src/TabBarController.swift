//
//  TabBarController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }

    private func setup() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black

        let homeNavigationController = Helper.makeNavigationController(
            image: .iconHomeTabBar,
            rootViewController: HomeViewController()
        )

        let instructionsNavigationController = Helper.makeNavigationController(
            image: .iconInstructionsTabBar,
            rootViewController: InstructionsViewController()
        )

        let statisticsNavigationController = Helper.makeNavigationController(
            image: .iconStatisticsTabBar,
            rootViewController: StatisticsViewController()
        )

        viewControllers = [
            homeNavigationController,
            instructionsNavigationController,
            statisticsNavigationController
        ]
    }
    
    private func style() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
    }
}
