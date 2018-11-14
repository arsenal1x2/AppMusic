//
//  PageViewController.swift
//  Music
//
//  Created by LTT on 11/14/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    private(set) lazy var arrViewController: [UIViewController] = {
        return [
            initViewController(id: Constants.StoryboardId.slideFirstVC),
            initViewController(id: Constants.StoryboardId.slideSecondVC),
            initViewController(id: Constants.StoryboardId.slideThirdVC)
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController =  arrViewController.first {
            setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initViewController(id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: id)
        return vc
    }
}

//MARK: PageViewControllerDataSource
extension PageViewController:UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexViewController = arrViewController.index(of: viewController) else {
            return nil
        }
        let previousIndex = indexViewController - 1
        if (previousIndex < 0) { return arrViewController.last }
        if (previousIndex >= arrViewController.count) { return nil }
        return arrViewController[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexViewController = arrViewController.index(of: viewController) else {
            return nil
        }
        let previousIndex = indexViewController + 1
        if (previousIndex > arrViewController.count) { return nil }
        if (previousIndex == arrViewController.count) { return arrViewController.first }
        return arrViewController[previousIndex]
    }
}
