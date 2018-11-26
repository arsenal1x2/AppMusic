//
//  AudioPlayer.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class AudioPlayer {
    static let sharedInstance = AudioPlayer()
    var player: AVPlayer!
    var isReplay: Bool = false
    var playerItem: AVPlayerItem!
    var isPlaying: Bool = false
    var duration: Float!
    var path:  String = ""
    var currentTime: Float!

    func setupAudio() {
        guard let url = URL(string: path) else { return }
        playerItem = AVPlayerItem(url:url)
        player = AVPlayer(playerItem:playerItem)
        player.volume = 0.5
        let timeDuration = CMTimeGetSeconds(playerItem.asset.duration)
        duration = Float(timeDuration)
        setupAudioSession()
        setupRemoteCommandCenter()
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

    func play() {
        player.play()
    }

    func pause() {
        player.pause()
    }

    func getCurrentTime() -> Float {
        let currentTime = player.currentTime()
        return Float(CMTimeGetSeconds(currentTime))
    }

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting the AVAudioSession:", error.localizedDescription)
        }
    }

    func sld_Duration(_ value: Float) {
        let timeToSeek = value * duration
        let time = CMTimeMake(Int64(timeToSeek), 1)
        player.seek(to: time)
    }

    func sld_Volume(_ value: Float) {
        player.volume = value
    }
}
