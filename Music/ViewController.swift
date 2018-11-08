//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import ImageSlideshow
class ViewController: UIViewController {

    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var buttonPlayMusic: UIButton!
    @IBOutlet weak var slider: UISlider!
    var isPlaying = true
    let localSource = [ImageSource(imageString: "download")!, ImageSource(imageString: "sontung")!]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupSilder() {
        slider.setThumbImage(UIImage(named: "icons8-record"), for: .normal)
        slider.setThumbImage(UIImage(named: "icons8-record"), for: .highlighted)

    }
    func setupSlideshow() {
        slideshow.slideshowInterval = 0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.pageIndicator = pageControl
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        slideshow.setImageInputs(localSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }
    func setupButton() {
        buttonPlayMusic.layer.cornerRadius = 0.5 * buttonPlayMusic.bounds.size.width
        buttonPlayMusic.layer.borderWidth = 1
        buttonPlayMusic.layer.borderColor = UIColor.white.cgColor
        buttonPlayMusic.clipsToBounds = true
    }
    func setupViews() {
        setupSilder()
        setupSlideshow()
        setupButton()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    @IBAction func clickButtonPlayMusic(_ sender: Any) {
       changeStatePlayButton(&isPlaying)
    }
    func changeStatePlayButton(_ isPlaying: inout Bool){
        if(!isPlaying){
            isPlaying = true
            let image = UIImage(named: "211876-128")!
            buttonPlayMusic.setImage(image, for: .normal)
            
        }else {
            isPlaying = false
            let image = UIImage(named: "216309-128")!
            buttonPlayMusic.setImage(image, for: .normal)
        }

    }


}

