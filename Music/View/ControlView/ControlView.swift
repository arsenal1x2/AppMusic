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
    @objc optional func controlview(_ controlview: ControlView, didSelectPlayAndPauseButton: UIButton, isPlaying: Bool)
    @objc optional func controlview(_ controlview: ControlView, didSelectReplayButton: UIButton, isReplay: Bool)
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
    var isReplay = false
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
        if isPlaying {
            playButton.setImage(UIImage(named: Constants.Icon.play), for: .normal)
        } else {
            playButton.setImage(UIImage(named: Constants.Icon.stop), for: .normal)
        }
    }

    @IBAction func clickPlayButton(_ sender: Any) {
        handle(isPlaying: isPlaying)
        delegateViewController?.controlview?(self, didSelectPlayAndPauseButton: playButton, isPlaying: isPlaying)
        isPlaying = !isPlaying
    }

    func handle(isPlaying: Bool) {
        if !isPlaying {
            playButton.setImage(UIImage(named: Constants.Icon.stop), for: .normal)
        } else {
            playButton.setImage(UIImage(named: Constants.Icon.play), for: .normal)
        }
    }

    @IBAction func clickReplayButton(_ sender: Any) {
        if isReplay {
           replayButton.setImage(UIImage(named: Constants.Icon.repeat2), for: .normal)
            isReplay = false
        } else {
           replayButton.setImage(UIImage(named: Constants.Icon.repeat1), for: .normal)
            isReplay = true
        }
        delegateViewController?.controlview?(self, didSelectReplayButton: replayButton, isReplay: isReplay)
    }

    @IBAction func clickSuffleButton(_ sender: Any) {
        delegateViewController?.controlview?(self, didSelectShuffleButton: shuffleButton)
    }

    @IBAction func clickbackButton(_ sender: Any) {
        delegateViewController?.controlview?(self, didSelectBackButton: backButton)
    }

    @IBAction func clickNextButton(_ sender: Any) {
        delegateViewController?.controlview?(self, didSelectNextButton: nextButton)
    }
}

//MARK: ViewController Delegate
extension ControlView: ViewControllerDelegate {
    func viewcontroller(_ viewcontroller: PlayViewController, songDidChanged: Track,index :Int, isPlaying: Bool) {
        self.isPlaying = isPlaying
    }
}
