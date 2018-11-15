//
//  PageViewController.swift
//  Music
//
//  Created by LTT on 11/14/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    func pageview(_ pageview:PageViewController, transitionCompleted: Bool)
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
}

