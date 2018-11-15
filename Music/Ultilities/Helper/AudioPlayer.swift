//
//  AudioPlayer.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    static let  sharedInstance = AudioPlayer()
    var pathString = ""
    var isPlaying = false
    var duration = Float()
    var currentTime = Float()
    var titleSong = ""
    var player = AVPlayer()
    var isRepeating =  false

    private init() {

    }

    func setupAudio() {
        var url:URL
        if let checkingUrl = URL(string: pathString) {
            url = checkingUrl
        } else {
            url = URL(fileURLWithPath: pathString)
        }
        let playerItem = AVPlayerItem(url:url)
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.volume = 0.5
        player.play()
        isPlaying = true
        isRepeating = true
    }

    func Repeat(_ repeatSong: Bool) {
        if repeatSong == true {
            isRepeating = true
        } else {
            isRepeating = false
        }
    }

    func action_PlayPause() {
        if isPlaying == false {
            player.play()
            isPlaying = true
        } else {
            player.pause()
            isPlaying = false
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
