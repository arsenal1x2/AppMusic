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

    func controlview(_ controlview: ControlView, didSelectPlayAndPauseButton: UIButton, isPlaying: Bool) {
        if isPlaying {
            stop()
        } else {
            play()
        }
        self.isPlaying = !isPlaying
    }

    func controlview(_ controlview: ControlView, didSelectNextButton: UIButton) {
        nextSong()
    }

    func controlview(_ controlview: ControlView, didSelectBackButton: UIButton) {
        previousSong()
    }

    func controlview(_ controlview: ControlView, didSelectReplayButton: UIButton, isReplay: Bool) {

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
        audioPlayer.sld_Duration(value)
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



//MARK: PageViewController
extension PlayViewController: PageViewControllerDelegate {
    func pageview(_ pageview: PageViewController, transitionCompleted: Bool, index: Int) {
        let song = listTrack.tracks[index]
        listTrack.currentIndexOfTrack = index
        resetUI()
        setupAudio(with: song)
        delegateSongView?.viewcontroller?(self, songDidChanged: song, index: index, isPlaying: isPlaying)
        delegateControlView?.viewcontroller?(self, songDidChanged: song, index: index, isPlaying: isPlaying)
        delegateListSongViewController?.playViewController?(self, indexIsPlaying: index)
        if isPlaying {
            play()
        }
    }
}

//MARK: ListSongViewController
extension PlayViewController: ListSongViewControllerDelegate {
    func listSongViewController(tracks: Tracks, index: Int) {
        self.listTrack = tracks
        self.indexPlay = index
        self.isPlaying = true
    }
}



