//
//  ArtworkView+Extension.swift
//  Music
//
//  Created by LTT on 11/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

//MARK: ControlViewDelegate
extension ArtworkView : ControlViewDelegate {

    func showImage(index: Int) {
        pageController.currentPage = index
        var frame = scrollView.frame
        frame.origin.y = 0
        frame.origin.x = CGFloat(index) * frame.size.width
        scrollView.scrollRectToVisible(frame, animated: true)
    }
}

//MARK: UIScrollViewDelegate
extension ArtworkView : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/self.frame.width)
        pageController.currentPage = Int(pageIndex)
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        if percentOffset.x > 0 && percentOffset.x <= 0.25 {
            images[0].transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            images[1].transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
        }
    }
}
