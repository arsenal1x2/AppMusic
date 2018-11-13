//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import AVFoundation

protocol ViewControllerDelegate: class {
    func updatePlayerView(timeDuration: String, timeTotal:String, duration:Float)
}

class ViewController: UIViewController {


    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var artworkView: ArtworkView!
    @IBOutlet weak var controlView: ControlView!
    var audio = AVAudioPlayer()
    var timer = Timer()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    weak var delegatePlayerView:ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        controlView.delegateViewController = self
        self.delegatePlayerView = playerView
        playerView.delegate = self
        controlView.delegateArtworkView = artworkView
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Chi-Yeu-Minh-Em-Chau-Khai-Phong", ofType: ".mp3")!))
        audio.prepareToPlay()
        playerView.slider.maximumValue = Float(audio.duration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateTime() {
        let minute: Int = Int(audio.currentTime / 60)
        let second: Int = Int(audio.currentTime.truncatingRemainder(dividingBy: 60))
        var durationTime = ""
        let totalTime = "3:20"
        var duration: Float = 1
        if (second < 10 && minute < 10) {
            durationTime = "0\(minute):0\(second) "
        } else {
            if second < 10 {
                durationTime = "\(minute):0\(second) "
            } else if minute < 10 {
                durationTime = "0\(minute):\(second) "
            } else {
                durationTime = "\(minute):\(second) "
            }
        }
        duration = Float(audio.currentTime)
        delegatePlayerView?.updatePlayerView(timeDuration: durationTime, timeTotal: totalTime, duration: duration)
    }
}
