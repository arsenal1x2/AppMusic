//
//  ControlView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

@objc protocol ControlViewDelegate: class {
    @objc optional func controlview(_ controlview: ControlView, didSelectNextButton: UIButton)
    @objc optional func controlview(_ controlview: ControlView, didSelectBackButton: UIButton)
    @objc optional func controlview(_ controlview: ControlView, didSelectPlayButton: UIButton)
    @objc optional func controlview(_ controlview: ControlView, didSelectPauseButton: UIButton)
    @objc optional func controlview(_ controlview: ControlView, didSelectReplayButton: UIButton)
    @objc optional func controlview(_ controlview: ControlView, didSelectShuffleButton: UIButton)
}

class ControlView: UIView, UITableViewDelegate{
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    weak var delegateViewController: ControlViewDelegate?
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
        handle(isPlaying: isPlaying)
        isPlaying = !isPlaying
    }

    func handle(isPlaying: Bool) {
        guard let delegate = delegateViewController else { return }
        if !isPlaying {
            playButton.setImage(UIImage(named: Constants.Icon.stop), for: .normal)
            delegate.controlview?(self, didSelectPlayButton: playButton)
        } else {
            playButton.setImage(UIImage(named: Constants.Icon.play), for: .normal)
            delegate.controlview?(self, didSelectPauseButton: playButton)

        }
    }

    @IBAction func clickReplayButton(_ sender: Any) {
        delegateViewController?.controlview?(self, didSelectReplayButton: replayButton)
    }

    @IBAction func clickSuffleButton(_ sender: Any) {
        delegateViewController?.controlview?(self, didSelectShuffleButton: shuffleButton)
    }

    @IBAction func clickbackButton(_ sender: Any) {
        playButton.setImage(UIImage(named: Constants.Icon.play), for: .normal)
        isPlaying = false
        delegateViewController?.controlview?(self, didSelectBackButton: backButton)
    }

    @IBAction func clickNextButton(_ sender: Any) {
        playButton.setImage(UIImage(named: Constants.Icon.play), for: .normal)
        isPlaying = false
        delegateViewController?.controlview?(self, didSelectNextButton: nextButton)
    }
}
