//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

@objc protocol ViewControllerDelegate: class {
    @objc optional func updatePlayerView(timeDuration: String, timeTotal: String, duration: Float)
    @objc optional func viewcontroller(_ viewcontroller: PlayViewController, isCompleted: Bool)
    @objc optional func viewcontroller(_ viewcontroller: PlayViewController, songDidChanged: Track, index: Int)
    @objc optional func viewcontroller(_ viewcontroller: PlayViewController, didStopSong: Track)
    @objc optional func viewcontroller(didLoad tracks: Tracks)
}

class PlayViewController: UIViewController {
    @IBOutlet weak var songView: SongView!
    @IBOutlet weak var navigationbar: CustomNavigationBar!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: ControlView!
    var audio = AVAudioPlayer()
    var timer = Timer()
    weak var delegatePlayerView: ViewControllerDelegate?
    weak var delegateControlView: ViewControllerDelegate?
    weak var delegateSongView: ViewControllerDelegate?
    weak var delegatePageView: ViewControllerDelegate?
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var listTrack:Tracks! = nil
    var isReplay = false
    var duration:Float = 0
    var currentTime:Float = 0
    var indexPlay: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        do {
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("bb> Receiving remote control events\n")
        } catch {
            print("bb> Audio Session error.\n")
        }
    }

    func setupViews() {
        setupAudioSession()
        controlView.delegateViewController = self
        self.delegatePlayerView = playerView
        playerView.delegate = self
        navigationbar.delegate = self
        songView.delegate = self
        self.delegateControlView = controlView
        self.delegateSongView = songView
        let url = URL(string: listTrack.tracks[indexPlay].url!)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        playerView.slider.maximumValue = Float(seconds)
        songView.nameSongLbl.text = listTrack.tracks[indexPlay].name
        songView.nameSingerLbl.text = listTrack.tracks[indexPlay].singer
    }

    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared();
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget {event in
            self.player.play()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget {event in
            self.player.pause()
            return .success
        }
    }

    func setupNowPlaying(song: Track) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.name
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = playerItem.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting the AVAudioSession:", error.localizedDescription)
        }
    }

    @objc func updateTime() {
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        let totalTimeString = Int.convertToTimeString(time: TimeInterval(seconds))
        let concurent: CMTime = playerItem.currentTime()
        let secondsCurrent: Float64 = CMTimeGetSeconds(concurent)
        let durationString = Float(secondsCurrent)
        print(durationString)
        let durationTimeString = Int.convertToTimeString(time: TimeInterval(secondsCurrent))
        delegatePlayerView?.updatePlayerView?(timeDuration: durationTimeString, timeTotal: totalTimeString, duration: durationString)
    }

    func nextSong() {
        let song = listTrack.next()
        changeTo(song: song)
    }

    func previousSong() {
        let song = listTrack.previous()
        changeTo(song: song)
    }

    func changeTo(song: Track) {
        stop()
        resetUI()
        let index = listTrack.currentIndexOfTrack
        playSong(song: song)
        delegateControlView?.viewcontroller?(self, songDidChanged: song, index: index)
        delegateSongView?.viewcontroller?(self, songDidChanged: song, index: index)
        delegatePageView?.viewcontroller?(self, songDidChanged: song, index: index)
    }

    func resetUI() {
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        playerView.slider.maximumValue = Float(seconds)
        updateTime()
    }

    func play() {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func playSong(song: Track) {
        guard let urlString = song.url else { return }
        guard let url = URL(string: urlString) else { return }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        setupNowPlaying(song: song)
        setupRemoteCommandCenter()
        play()
    }

    func stop() {
        player.pause()
        timer.invalidate()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewcontroller = segue.destination as? PageViewController else { return }
        viewcontroller.pageViewDelegate = self
        self.delegatePageView = viewcontroller
        delegatePageView?.viewcontroller!(didLoad: listTrack)
    }
}

