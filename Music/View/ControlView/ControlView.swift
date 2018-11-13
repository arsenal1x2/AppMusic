//
//  ControlView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ControlView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    weak var delegate: ControlViewDelegate?
    var isPlaying = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()
    }

    @IBAction func clickPlayButton(_ sender: Any) {
        if !isPlaying {
            playButton.setImage(UIImage(named: "326570-256 "), for: .normal)
        } else {
            playButton.setImage(UIImage(named: "211876-128"), for: .normal)
        }
        isPlaying = !isPlaying
    }

    @IBAction func clickbackButton(_ sender: Any) {
        delegate?.backSong(sender: self)
    }

    @IBAction func clickNextButton(_ sender: Any) {
        delegate?.nextSong(sender: self)

    }
}
protocol ControlViewDelegate: class {
    func nextSong(sender: ControlView)
    func backSong(sender: ControlView)
}
