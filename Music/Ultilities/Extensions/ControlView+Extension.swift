//
//  ControlView+Extension.swift
//  Music
//
//  Created by LTT on 11/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

//MARK: ViewController Delegate
extension ControlView: ViewControllerDelegate {
    func viewcontroller(_ viewcontroller: ViewController, didNextSong: Bool) {
        isPlaying = true
        playButton.setImage(UIImage(named: Constants.Icon.stop), for: .normal)
    }
}
