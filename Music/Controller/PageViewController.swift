//
//  PageViewController.swift
//  Music
//
//  Created by LTT on 11/14/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    func pageview(_ pageview:PageViewController, transitionCompleted: Bool, index: Int)
}

class PageViewController: UIPageViewController {
    private(set) lazy var arrayViewController: [ImageViewController] = [ImageViewController]()
    var viewcontroller:ViewController = ViewController()
    private(set) lazy var pageControl = UIPageControl()
    weak var pageViewDelegate: PageViewControllerDelegate?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        dataSource = self
        if let firstViewController =  arrayViewController.first {
            setViewControllers([firstViewController], direction: .reverse, animated: true, completion:nil)
        }
        configurePageControl()
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurePageControl() {
            pageControl = UIPageControl(frame: CGRect(x: 0,y:self.view.frame.midY - 10,width: self.view.bounds.width,height: 50))
            self.pageControl.numberOfPages = viewcontroller.listSong.listSong.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.black
            self.pageControl.pageIndicatorTintColor = UIColor.white
            self.pageControl.currentPageIndicatorTintColor = UIColor.black
            self.view.addSubview(pageControl)
    }

    func loadData() {
        for index in 0...viewcontroller.listSong.listSong.count - 1 {
            let storyboard = UIStoryboard.init(storyboard: .main)
            let vc:ImageViewController = storyboard.instantiateViewController()
            vc.loadView()
            vc.loadImage(image: viewcontroller.listSong.listSong[index].image)
            arrayViewController.append(vc)
        }
    }
    func changeTo(index: Int) {
        let vc = arrayViewController[index]
        setViewControllers([vc], direction: .reverse, animated: true) { (_) in
            self.pageControl.currentPage = index
        }
    }
}

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
        self.pageViewDelegate?.pageview(self, transitionCompleted: true, index: pageControl.currentPage)
    }
}
extension PageViewController:ViewControllerDelegate {

    func viewcontroller(_ viewcontroller: ViewController, songDidChanged: Song, index: Int) {
       changeTo(index: index)
    }
}


