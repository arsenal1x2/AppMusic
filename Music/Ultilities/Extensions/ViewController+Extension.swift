//
//  ViewController+Extension.swift
//  Music
//
//  Created by LTT on 11/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import AVFoundation
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

    func controlview(_ controlview: ControlView, didSelectReplayButton: UIButton, isReplay: Bool) {
        self.isReplay = isReplay
    }

    func controlview(_ controlview: ControlView, didSelectShuffleButton: UIButton) {
        print("Suffle")
    }
}

//MARK: PlayerViewDelegate
extension ViewController: PlayerViewDelegate {
    func sliderDidBeginChange() {
        timer.invalidate()
    }


    func sliderDidChanged(value: Float, sender: PlayerView) {
        audio.currentTime = TimeInterval(value)
        play()
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

//MARK: AVAudioDelegate
extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(listSong.indexOfConcurentSong == listSong.listSong.count - 1) {
            if(isReplay) {
                let song = listSong.listSong[0]
                playSong(song: song)
                delegateControlView?.viewcontroller?(self, songDidChanged: song, index: 0)
                delegateSongView?.viewcontroller?(self, songDidChanged: song, index: 0)
            }
            listSong.indexOfConcurentSong = 0
        } else {
            listSong.indexOfConcurentSong += 1
            let song = listSong.listSong[listSong.indexOfConcurentSong]
            playSong(song: song)
            delegateControlView?.viewcontroller?(self, songDidChanged: song, index: listSong.indexOfConcurentSong)
            delegateSongView?.viewcontroller?(self, songDidChanged: song, index: listSong.indexOfConcurentSong)
        }
    }
}

//MARK: PageViewController
extension ViewController:PageViewControllerDelegate {
    func pageview(_ pageview: PageViewController, transitionCompleted: Bool, index: Int) {
       let song = listSong.listSong[index]
       resetUI()
       playSong(song: song)
       delegateSongView?.viewcontroller?(self, songDidChanged: song, index: index)
       delegateControlView?.viewcontroller?(self, songDidChanged: song, index: index)
    }
}
