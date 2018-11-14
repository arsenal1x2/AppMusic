//
//  PlayerView+Extension.swift
//  Music
//
//  Created by LTT on 11/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

//MARK: ViewControllerDelegate
extension PlayerView: ViewControllerDelegate {

    func updatePlayerView(timeDuration: String, timeTotal: String, duration: Float) {
        updateFrame(with: timeDuration, timeTotal: timeTotal, duration: duration)
    }
}


