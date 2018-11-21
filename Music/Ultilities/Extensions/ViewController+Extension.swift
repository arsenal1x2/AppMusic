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
extension PlayViewController: ControlViewDelegate{

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
extension PlayViewController: PlayerViewDelegate {
    func sliderDidBeginChange() {
        timer.invalidate()
    }

    func sliderDidChanged(value: Float, sender: PlayerView) {
        let seconds : Int64 = Int64(value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player?.play()
        }
    }
}

//MARK:CustombarNavigationDelegate
extension PlayViewController: CustomNavigationBarDelegate {

    func navigationbar(_ navigationbar: CustomNavigationBar, didSelectLeftButton: UIButton) {
        print("clicked left Item")
    }

    func navigationbar(_ navigationbar: CustomNavigationBar, didSelectRightButton: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: SongViewDelegate
extension PlayViewController: SongViewDelegate {

    func songview(_ songview: SongView, didSelectAddButton: UIButton) {
        print("Add Song")
    }

    func songview(_ songview: SongView, didSelectMoreButton: UIButton) {
        print("More")
    }
}

//MARK: AVAudioDelegate
extension PlayViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(listTrack.currentIndexOfTrack == listTrack.tracks.count - 1) {
            if(isReplay) {
                let song = listTrack.tracks[0]
                playSong(song: song)
                delegateControlView?.viewcontroller?(self, songDidChanged: song, index: 0)
                delegateSongView?.viewcontroller?(self, songDidChanged: song, index: 0)
            }
            listTrack.currentIndexOfTrack = 0
        } else {
            listTrack.currentIndexOfTrack += 1
            let song = listTrack.tracks[listTrack.currentIndexOfTrack]
            playSong(song: song)
            delegateControlView?.viewcontroller?(self, songDidChanged: song, index: listTrack.currentIndexOfTrack)
            delegateSongView?.viewcontroller?(self, songDidChanged: song, index: listTrack.currentIndexOfTrack)
        }
    }
}

//MARK: PageViewController
extension PlayViewController: PageViewControllerDelegate {
    func pageview(_ pageview: PageViewController, transitionCompleted: Bool, index: Int) {
        let song = listTrack.tracks[index]
        listTrack.currentIndexOfTrack = index
        stop()
        resetUI()
        playSong(song: song)
        delegateSongView?.viewcontroller?(self, songDidChanged: song, index: index)
        delegateControlView?.viewcontroller?(self, songDidChanged: song, index: index)
    }
}

//MARK: ListSongViewController
extension PlayViewController: ListSongViewControllerDelegate {
    func listSongViewController(tracks: Tracks, index: Int) {
        self.listTrack = tracks
        self.indexPlay = index
    }
}



