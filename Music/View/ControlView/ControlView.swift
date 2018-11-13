//
//  ControlView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

@objc protocol ControlViewDelegate: class {
    @objc optional func nextSong(sender: ControlView)
    @objc optional func backSong(sender: ControlView)
    @objc optional func play(sender: ControlView)
    @objc optional func stop(sender: ControlView)
}

class ControlView: UIView {
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    weak var delegateViewController: ControlViewDelegate?
    weak var delegateArtworkView: ControlViewDelegate?
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
            playButton.setImage(UIImage(named: icon.stop), for: .normal)
            guard let delegate = delegateViewController else { return }
            delegate.play?(sender: self)
        } else {
            playButton.setImage(UIImage(named: icon.play), for: .normal)
            delegateViewController?.stop?(sender: self)
        }
        isPlaying = !isPlaying
    }

    @IBAction func clickbackButton(_ sender: Any) {
        delegateArtworkView?.backSong?(sender: self)
    }

    @IBAction func clickNextButton(_ sender: Any) {
        delegateArtworkView?.nextSong?(sender: self)
    }
}
