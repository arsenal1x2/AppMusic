//
//  ArtworkView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ArtworkView: UIView,UIScrollViewDelegate {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var frontScrollViews: [UIScrollView] = []
    let pageImage = ["download","sontung"]
    var first = false
    var currentPage = 0
    var photo: [UIImageView] = []
    var images:[UIImageView] = []
    var controlView:ControlView = ControlView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("ArtworkView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scrollView.delegate = self
        images = createImages()
        setupSlideScrollView(slides: images)

        pageController.numberOfPages = images.count
        pageController.currentPage = 0
        self.bringSubview(toFront: pageController)
        controlView.delegate = self

        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/contentView.frame.width)
        pageController.currentPage = Int(pageIndex)

        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)

        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {

            images[0].transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            images[1].transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)

        }
    }
    func createImages() -> [UIImageView] {
        let imgView1 = UIImageView(image: UIImage(named: "download")!)
        let imgView2 = UIImageView(image: UIImage(named: "sontung")!)
        return [imgView1,imgView2]
    }
    func setupSlideScrollView(slides : [UIImageView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        scrollView.contentSize = CGSize(width: contentView.frame.width * CGFloat(slides.count), height: contentView.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: contentView.frame.width * CGFloat(i), y: 0, width: contentView.frame.width, height: contentView.frame.height)
            scrollView.addSubview(images[i])
        }
    }
}
extension ArtworkView:ControlViewDelegate{
    func backSong(sender: ControlView) {
        var index = pageController.currentPage
        if(index == 0){
            index = images.count - 1
        }else {
            index = index - 1
        }
        pageController.currentPage = index
        var frame = scrollView.frame
        frame.origin.y = 0
        frame.origin.x = CGFloat(index) * frame.size.width
        scrollView.scrollRectToVisible(frame, animated: true)
    }

    func nextSong(sender: ControlView) {
        var index = pageController.currentPage
        if(index == images.count - 1){
            index = 0
        }else {
            index = index + 1
        }
        pageController.currentPage = index
        var frame = scrollView.frame
        frame.origin.y = 0
        frame.origin.x = CGFloat(index) * frame.size.width
        scrollView.scrollRectToVisible(frame, animated: true)

    }

}
