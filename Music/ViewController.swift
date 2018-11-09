//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import ImageSlideshow
import AVFoundation
class ViewController: UIViewController {


    @IBOutlet weak var durationTimeLbl: UILabel!
    @IBOutlet weak var concurentTimeLbl: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var buttonPlayMusic: UIButton!
    @IBOutlet weak var slider: UISlider!
    var audio:AVAudioPlayer = AVAudioPlayer()
    var isPlaying = false
    var timer:Timer = Timer()
    let localSource = [ImageSource(imageString: "download")!, ImageSource(imageString: "sontung")!]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupSilder() {
        slider.setThumbImage(UIImage(named: "icons8-record"), for: .normal)
        slider.setThumbImage(UIImage(named: "icons8-record"), for: .highlighted)
        slider.maximumValue = Float(audio.duration)
        

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
        setupAudio()
        setupSilder()
        setupSlideshow()
        setupButton()
        setupLabel()

    }
    func setupLabel() {
        self.concurentTimeLbl.text = "0:00"
        let minu: Int = Int(audio.duration / 60)
        let sec: Int = Int(audio.duration.truncatingRemainder(dividingBy: 60))
        print(sec)
        self.durationTimeLbl.text = "\(minu):\(sec) "
    }
    @objc func updateFrame() {
        let minu: Int = Int(audio.currentTime / 60)
        let sec: Int = Int(audio.currentTime.truncatingRemainder(dividingBy: 60))

        if (sec < 10 && minu < 10){
            self.concurentTimeLbl.text = "0\(minu):0\(sec) "

        }else{
            if sec < 10 {
                self.concurentTimeLbl.text = "\(minu):0\(sec) "
            } else if minu < 10 {
                self.concurentTimeLbl.text = "0\(minu):\(sec) "
            }else{
                self.concurentTimeLbl.text = "\(minu):\(sec) "
            }

        }


        slider.value = Float(audio.currentTime)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    func setupAudio() {
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Chi-Yeu-Minh-Em-Chau-Khai-Phong", ofType: "mp3")!))
        audio.prepareToPlay()

    }
    @IBAction func clickButtonPlayMusic(_ sender: Any) {
       changeStatePlayButton(&isPlaying)
    }
    func changeStatePlayButton(_ isPlaying: inout Bool){
        if(!isPlaying){
            isPlaying = true
            let image = UIImage(named: "216309-128")!
            buttonPlayMusic.setImage(image, for: .normal)
            audio.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateFrame), userInfo: nil, repeats: true)
            
        }else {
            isPlaying = false
            let image = UIImage(named: "211876-128")!
            buttonPlayMusic.setImage(image, for: .normal)
            audio.stop()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateFrame), userInfo: nil, repeats: true)
            timer.invalidate()
        }

    }

    @IBAction func changedSlidervalue(_ sender: Any) {
        audio.currentTime = TimeInterval(Int(slider.value))
        updateFrame()
    }


}

