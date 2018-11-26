//
//  Tracks.swift
//  Music
//
//  Created by LTT on 11/21/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

class Tracks: NSObject {
    var tracks: [Track]
    var currentIndexOfTrack: Int = 0

    init(tracks:[Track]) {
        self.tracks = tracks.sorted(by: { $0 < $1 })
    }

    func next() -> Track {
        if currentIndexOfTrack == tracks.count - 1 {
            currentIndexOfTrack = 0
        } else {
            currentIndexOfTrack += 1
        }
        return tracks[currentIndexOfTrack]
    }

    func previous() -> Track {
        if currentIndexOfTrack == 0 {
            currentIndexOfTrack = tracks.count - 1
        } else {
            currentIndexOfTrack -= 1
        }
        return tracks[currentIndexOfTrack]
    }
}
