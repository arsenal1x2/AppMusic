//
//  ViewController+Extension.swift
//  Music
//
//  Created by LTT on 11/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

//MARK: ControlViewDelegate
extension ViewController: ControlViewDelegate {

    func play(sender: ControlView) {
        audio.play()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func stop(sender: ControlView) {
        audio.stop()
        timer.invalidate()
    }
}

//MARK: PlayerViewDelegate
extension ViewController: PlayerViewDelegate {

    func sliderDidChanged(value: Float, sender: PlayerView) {
        audio.currentTime = TimeInterval(value)
    }
}
