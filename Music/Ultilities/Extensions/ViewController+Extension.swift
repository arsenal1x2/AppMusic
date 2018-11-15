//
//  ViewController+Extension.swift
//  Music
//
//  Created by LTT on 11/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import UIKit

//MARK: ControlViewDelegate
extension ViewController: ControlViewDelegate{

    func controlview(_ controlview: ControlView, didSelectPlayButton: UIButton) {
        play()
    }

    func controlview(_ controlview: ControlView, didSelectPauseButton: UIButton) {
        stop()
    }

    func controlview(_ controlview: ControlView, didSelectNextButton: UIButton) {
        nextSong()
    }

    func controlview(_ controlview: ControlView, didSelectBackButton: UIButton) {
        previousSong()
    }

    func controlview(_ controlview: ControlView, didSelectReplayButton: UIButton) {
        print("Replay")
    }

    func controlview(_ controlview: ControlView, didSelectShuffleButton: UIButton) {
        print("Suffle")
    }
}

//MARK: PlayerViewDelegate
extension ViewController: PlayerViewDelegate {

    func sliderDidChanged(value: Float, sender: PlayerView) {
        audio.currentTime = TimeInterval(value)
    }
}

//MARK:CustombarNavigationDelegate
extension ViewController:CustomNavigationBarDelegate {

    func navigationbar(_ navigationbar: CustomNavigationBar, didSelectLeftButton: UIButton) {
        print("clicked left Item")
    }

    func navigationbar(_ navigationbar: CustomNavigationBar, didSelectRightButton: UIButton) {
        print("clicked right item")
    }

}

//MARK: SongViewDelegate
extension ViewController:SongViewDelegate {

    func songview(_ songview: SongView, didSelectAddButton: UIButton) {
        print("Add Song")
    }

    func songview(_ songview: SongView, didSelectMoreButton: UIButton) {
        print("More")
    }
}
