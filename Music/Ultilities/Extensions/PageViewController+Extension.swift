//
//  PageViewController+Extension.swift
//  Music
//
//  Created by LTT on 11/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

//MARK: PageViewControllerDataSource
extension PageViewController:UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexViewController = arrayViewController.index(of: viewController as! ImageViewController) else {
            return nil
        }
        var previousIndex = indexViewController - 1
        if (previousIndex < 0) { previousIndex = arrayViewController.count - 1 }
        if (previousIndex >= arrayViewController.count) { return nil }
        return arrayViewController[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexViewController = arrayViewController.index(of: viewController as! ImageViewController) else {
            return nil
        }
        let nextIndex = indexViewController + 1
        if (nextIndex > arrayViewController.count) { return nil }
        if (nextIndex == arrayViewController.count) { return arrayViewController.first }
        return arrayViewController[nextIndex]
    }
}

//MARK: PageViewControllerDelegate
extension PageViewController:UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = arrayViewController.index(of: pageContentViewController as! ImageViewController)!

    }
}
