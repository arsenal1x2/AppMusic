//
//  PageViewController.swift
//  Music
//
//  Created by LTT on 11/14/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    private(set) lazy var arrayViewController: [ImageViewController] = [ImageViewController]()
    private(set) lazy var arrayImageName:[String] = {
        return [Constants.Image.sontung, Constants.Image.arsenal, Constants.Image.picture]
    }()
    private(set) lazy var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        dataSource = self
        if let firstViewController =  arrayViewController.first {
            setViewControllers([firstViewController], direction: .reverse, animated: true, completion:nil)
            firstViewController.pictureImg.image = UIImage(named: (arrayImageName.first)!)

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
            self.pageControl.numberOfPages = arrayImageName.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.black
            self.pageControl.pageIndicatorTintColor = UIColor.white
            self.pageControl.currentPageIndicatorTintColor = UIColor.black
            self.view.addSubview(pageControl)
    }

    func loadData() {
        for index in 0...arrayImageName.count - 1 {
            let storyboard = UIStoryboard.init(storyboard: .main)
            let viewcontroller:ImageViewController = storyboard.instantiateViewController()
            viewcontroller.loadView()
            guard let image = UIImage(named: arrayImageName[index]) else { return }
            viewcontroller.loadImage(image: image)
            arrayViewController.append(viewcontroller)
        }
    }
}

