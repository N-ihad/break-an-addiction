//
//  MainTabController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/14/20.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureGeneralAppUI()
        configureTabBar()
        configureViewControllers()
    }

    // MARK: - Helpers
    
    func configureGeneralAppUI() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
        
//        navigationController?.view.backgroundColor = .clear
    }
    
    func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    func configureViewControllers() {
        let homeVC  = HomeVC()
        let homeNav = templateNavigationController(image: UIImage(systemName: "house")!, rootViewController: homeVC)
        
        let instructionsVC = InstructionsVC()
        let instructionsNav = templateNavigationController(image: UIImage(systemName: "list.bullet.rectangle")!, rootViewController: instructionsVC)
        
        let statisticsVC = StatisticsVC()
        let statisticsNav = templateNavigationController(image: UIImage(systemName: "chart.bar")!, rootViewController: statisticsVC)
        
        viewControllers = [homeNav, instructionsNav, statisticsNav]
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: rootViewController)
        navCtrl.tabBarItem.image = image
        navCtrl.navigationBar.barTintColor = .white
        return navCtrl
    }
    
}
