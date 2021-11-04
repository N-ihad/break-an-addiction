//
//  MainTabController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

final class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }

    private func setup() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black

        let homeNavigationController = templateNavigationController(
            image: .iconHomeTabBar, rootViewController: HomeViewController()
        )

        let instructionsNavigationController = templateNavigationController(
            image: .iconInstructionsTabBar, rootViewController: InstructionsViewController()
        )

        let statisticsNavigationController = templateNavigationController(
            image: .iconStatisticsTabBar, rootViewController: StatisticsViewController()
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
//        navigationController?.view.backgroundColor = .clear
    }
    
    private func templateNavigationController(
        image: UIImage,
        rootViewController: UIViewController
    ) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.barTintColor = .white
        return navigationController
    }
}
