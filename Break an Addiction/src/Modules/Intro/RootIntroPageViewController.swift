//
//  RootIntroPageViewController.swift
//  Break an Addiction
//
//  Created by Nihad on 12/11/20.
//

import UIKit

final class RootIntroPageViewController: UIPageViewController {

    lazy var pageViewControllers: [UIViewController] = {
        let firstPageViewController = FirstPageViewController()
        let secondPageViewController = SecondPageViewController()
        let thirdPageViewController = ThirdPageViewController()
        return [firstPageViewController, secondPageViewController, thirdPageViewController]
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }

    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews where subView is UIPageControl {
            subView.frame.origin.y = view.frame.size.height - 125
        }
    }

    private func setup() {
        dataSource = self
        delegate = self

        if let firstPageViewController = pageViewControllers.first {
            setViewControllers([firstPageViewController], direction: .forward, animated: true)
        }
    }
    
    private func style() {
        view.backgroundColor = .themeDarkGreen
    }
    
    func presentNextPage(animated: Bool = true) {
        guard let currentViewController = viewControllers?.first,
              let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else {
            return
        }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

    func presentPreviousPage(animated: Bool = true) {
        guard let currentViewController = viewControllers?.first,
              let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else {
            return
        }
        setViewControllers([previousViewController], direction: .reverse, animated: animated)
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension RootIntroPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentViewController = viewControllers?.first else {
            return 0
        }
        let currentIndex = pageViewControllers.firstIndex(of: currentViewController)!
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.firstIndex(of: viewController),
              (0..<pageViewControllers.count).contains(index - 1) else {
            return nil
        }
        return pageViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.firstIndex(of: viewController),
              pageViewControllers.count > index + 1 else {
            return nil
        }
        return pageViewControllers[index + 1]
    }
}
