//
//  SongView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

protocol SongViewDelegate: class {
    func songview(_ songview: SongView, didSelectAddButton: UIButton)
    func songview(_ songview: SongView, didSelectMoreButton: UIButton)
}

class SongView: UIView {
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var nameSingerLbl: UILabel!
    @IBOutlet weak var nameSongLbl: UILabel!
    weak var delegate:SongViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @IBAction func clickMoreButton(_ sender: Any) {
        delegate?.songview(self, didSelectAddButton: addSongButton)
    }

    @IBAction func clickAddSongButton(_ sender: Any) {
        delegate?.songview(self, didSelectMoreButton: moreButton)
    }

    private func commonInit() {
        loadNib()
    }
}

//MARK: ViewControllerDelegate
extension SongView: ViewControllerDelegate {
    func viewcontroller(_ viewcontroller: PlayViewController, songDidChanged: Track, index: Int, isPlaying: Bool) {
        nameSingerLbl.text = songDidChanged.singer
        nameSongLbl.text = songDidChanged.name
    }
}
