//
//  ArtworkView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ArtworkView: UIView {
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var images: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()
        scrollView.delegate = self
        images = createImages()
        setupSlideScrollView(slides: images)
        pageController.numberOfPages = images.count
        pageController.currentPage = 0
        self.bringSubview(toFront: pageController)
    }

    func createImages() -> [UIImageView] {
        let imgView1 = UIImageView(image: UIImage(named: Constants.Image.arsenal)!)
        let imgView2 = UIImageView(image: UIImage(named: Constants.Image.sontung)!)
        return [imgView1,imgView2]
    }

    func setupSlideScrollView(slides : [UIImageView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: Int(self.frame.height))
        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(slides.count), height: self.frame.height)
        scrollView.isPagingEnabled = true
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: self.frame.width * CGFloat(i), y: 0, width: self.frame.width, height: self.frame.height)
            scrollView.addSubview(images[i])
        }
    }
}

