//
//  OnboardingPageViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 3/7/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(color: "First"),
                self.newColoredViewController(color: "Purple"),
                self.newColoredViewController(color: "Green"),
                self.newColoredViewController(color: "Yellow"),
                self.newColoredViewController(color: "Last")]
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            scrollToViewController(viewController: firstViewController)
        }
        
        onboardingDelegate?.onboardingPageViewController(onboardingPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(viewController: nextViewController)
        }
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
    private func newColoredViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil) .
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }

    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            self.notifyOnboardingDelegateOfNewIndex()
        })
    }
    
    private func notifyOnboardingDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.firstIndex(of: firstViewController) { onboardingDelegate?.onboardingPageViewController(onboardingPageViewController: self, didUpdatePageIndex: index)
            }
        }
}



extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }

}

extension OnboardingPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyOnboardingDelegateOfNewIndex()
    }

}

protocol OnboardingPageViewControllerDelegate: class {

    /**
     Called when the number of pages is updated.

     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func onboardingPageViewController(onboardingPageViewController: OnboardingPageViewController,
                                    didUpdatePageCount count: Int)

    /**
     Called when the current index is updated.

     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func onboardingPageViewController(onboardingPageViewController: OnboardingPageViewController,
                                    didUpdatePageIndex index: Int)
}
