//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol ViewControllerDelegate: class {
    @objc optional func updatePlayerView(timeDuration: String, timeTotal: String, duration: Float)
    @objc optional func viewcontroller(_ viewcontroller: ViewController, isCompleted: Bool)
    @objc optional func viewcontroller(_ viewcontroller:ViewController, didNextSong: Bool)
}

class ViewController: UIViewController {
    @IBOutlet weak var songView: SongView!
    @IBOutlet weak var navigationbar: CustomNavigationBar!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: ControlView!
    var audio = AVAudioPlayer()
    var timer = Timer()
    weak var delegatePlayerView: ViewControllerDelegate?
    weak var delegateControlView: ViewControllerDelegate?
    let listSong:ListSong = ListSong()

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
        self.delegateControlView = controlView
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: listSong.listSong[0].name, ofType: Constants.FileType.mp3)!))
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
        delegatePlayerView?.updatePlayerView?(timeDuration: durationTime, timeTotal: totalTime, duration: duration)
    }
    func nextSong() {
        stop()
        resetUI()
        playSong(song: listSong.Next())
        delegateControlView?.viewcontroller?(self, didNextSong: true)
    }
    func previousSong() {
        stop()
        resetUI()
        playSong(song: listSong.Previous())
        delegateControlView?.viewcontroller?(self, didNextSong: true)
    }
    func resetUI() {
        playerView.slider.maximumValue = Float(audio.duration)
        let totalTime = Int.convertToTimeString(time: audio.duration)
        let duration = Float(audio.currentTime)
        let durationTime = "0:00"
        delegatePlayerView?.updatePlayerView?(timeDuration: durationTime, timeTotal: totalTime, duration: duration)
    }
    func playSong(song: Song) {
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: song.name, ofType: Constants.FileType.mp3)!))
        audio.prepareToPlay()
        play()
    }
    func play() {
        audio.play()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    func stop() {
        audio.stop()
        timer.invalidate()
    }
}
extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {

    }
}
