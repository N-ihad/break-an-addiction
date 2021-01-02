//
//  IntroVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

class RootIntroPageVC: UIPageViewController {
    
    // MARK: - Properties
    
    lazy var pagesVCList: [UIViewController] = {
        let firstPageVC = FirstPageVC()
        let secondPageVC = SecondPageVC()
        let thirdPageVC = ThirdPageVC()
        return [firstPageVC, secondPageVC, thirdPageVC]
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegates()
        configureUI()
    }

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews {
            if  subView is  UIPageControl {
                subView.frame.origin.y = self.view.frame.size.height - 125
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureDelegates() {
        self.dataSource = self
        self.delegate = self
    }
    
    func configureUI() {
        if let firstPageVC = pagesVCList.first {
            self.setViewControllers([firstPageVC], direction: .forward, animated: true, completion: nil)
        }
        
        view.backgroundColor = .themeDarkGreen
    }
    
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }
}



extension RootIntroPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pagesVCList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC = self.viewControllers?.first else {return 0}
        let currentIndex = pagesVCList.firstIndex(of: currentVC)!
        
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pagesVCList.firstIndex(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard (0 ..< pagesVCList.count).contains(previousIndex) else {return nil}
        
        return pagesVCList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pagesVCList.firstIndex(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard pagesVCList.count > nextIndex else {return nil}
        
        return pagesVCList[nextIndex]
    }
}
