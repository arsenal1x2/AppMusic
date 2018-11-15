//
//  SongView+Extension.swift
//  Music
//
//  Created by LTT on 11/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

extension SongView: ViewControllerDelegate {
    func viewcontroller(_ viewcontroller: ViewController, songDidChanged: Song) {
        nameSingerLbl.text = songDidChanged.singer
        nameSongLbl.text = songDidChanged.title
    }
}
