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
    @IBOutlet weak var songView: SongView!
    @IBOutlet weak var navigationbar: CustomNavigationBar!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: ControlView!
    var audio = AVAudioPlayer()
    var timer = Timer()
    weak var delegatePlayerView:ViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        controlView.delegateViewController = self
        self.delegatePlayerView = playerView
        playerView.delegate = self
        navigationbar.delegate = self
        songView.delegate = self

        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: Constants.NameSong, ofType: Constants.FileType.mp3)!))
        audio.prepareToPlay()
        playerView.slider.maximumValue = Float(audio.duration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateTime() {
        let totalTime = Int.convertToTimeString(time: audio.duration)
        let duration = Float(audio.currentTime)
        let durationTime = Int.convertToTimeString(time: audio.currentTime)
        delegatePlayerView?.updatePlayerView(timeDuration: durationTime, timeTotal: totalTime, duration: duration)
    }
}
