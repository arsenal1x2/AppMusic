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
    @objc optional func viewcontroller(_ viewcontroller: PlayViewController, songDidChanged: Track, index: Int, isPlaying: Bool)
    @objc optional func viewcontroller(_ viewcontroller: PlayViewController, didStopSong: Track)
    @objc optional func viewcontroller(didLoad tracks: Tracks)
    @objc optional func playViewController(_ playViewController: PlayViewController, indexIsPlaying: Int)
}

class PlayViewController: UIViewController {
    @IBOutlet weak var songView: SongView!
    @IBOutlet weak var navigationbar: CustomNavigationBar!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: ControlView!
    var timer = Timer()
    weak var delegatePlayerView: ViewControllerDelegate?
    weak var delegateControlView: ViewControllerDelegate?
    weak var delegateSongView: ViewControllerDelegate?
    weak var delegatePageView: ViewControllerDelegate?
    weak var delegateListSongViewController: ViewControllerDelegate?
    var listTrack:Tracks! = nil
    var indexPlay: Int = 0
    var audioPlayer = AudioPlayer.sharedInstance
    var isPlaying: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        setupDelegate()
        setupPlayer()
    }

    func setupPlayer() {
        let track = listTrack.tracks[indexPlay]
        setupAudio(with: track)
        delegateControlView?.viewcontroller?(self, songDidChanged: track, index: indexPlay, isPlaying: isPlaying)
        delegateSongView?.viewcontroller?(self, songDidChanged: track, index: indexPlay, isPlaying: isPlaying)
        delegatePageView?.viewcontroller?(self, songDidChanged: track, index: indexPlay, isPlaying: isPlaying)
        if isPlaying {
            play()
            delegateControlView?.viewcontroller?(self, songDidChanged: track, index: indexPlay, isPlaying: isPlaying)
        }
    }

    func setupDelegate() {
        controlView.delegateViewController = self
        self.delegatePlayerView = playerView
        playerView.delegate = self
        navigationbar.delegate = self
        songView.delegate = self
        self.delegateControlView = controlView
        self.delegateSongView = songView
    }

    func setupNowPlaying(song: Track) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.name
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer.player.rate
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }

    @objc func updateTime() {
        guard let duration = audioPlayer.duration else { return }
        let current = audioPlayer.getCurrentTime()
        let totalTimeString = Int.convertToTimeString(time: TimeInterval(duration))
        let durationTimeString = Int.convertToTimeString(time: TimeInterval(current))
        delegatePlayerView?.updatePlayerView?(timeDuration: durationTimeString, timeTotal: totalTimeString, duration: current)
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
        resetUI()
        let index = listTrack.currentIndexOfTrack
        setupAudio(with: song)
        delegateControlView?.viewcontroller?(self, songDidChanged: song, index: index, isPlaying: isPlaying)
        delegateSongView?.viewcontroller?(self, songDidChanged: song, index: index, isPlaying: isPlaying)
        delegatePageView?.viewcontroller?(self, songDidChanged: song, index: index, isPlaying: isPlaying)
        if(isPlaying) {
            play()
        }
    }

    func resetUI() {
        guard let duration = audioPlayer.duration else { return }
        playerView.slider.maximumValue = duration
        updateTime()
    }

    func play() {
        audioPlayer.play()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func stop() {
        audioPlayer.pause()
        timer.invalidate()
    }

    func setupAudio(with track: Track) {
        audioPlayer.path = track.url
        audioPlayer.setupAudio()
        setupNowPlaying(song: track)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewcontroller = segue.destination as? PageViewController else { return }
        viewcontroller.pageViewDelegate = self
        self.delegatePageView = viewcontroller
        delegatePageView?.viewcontroller!(didLoad: listTrack)
    }
}

