//
//  PlayerView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

protocol PlayerViewDelegate: class {
    func sliderDidChanged(value: Float, sender: PlayerView)
    func sliderDidBeginChange()
}

class PlayerView: UIView {
    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet weak var totalTimeLbl: UILabel!
    @IBOutlet weak var slider: UISlider!
    weak var delegate:PlayerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit() {
        loadNib()
        setupSlider()
    }

    private func setupSlider() {
        slider.setThumbImage(UIImage(named: Constants.Icon.slider), for: .normal)
        slider.setThumbImage(UIImage(named: Constants.Icon.slider), for: .highlighted)
        let event = UIControlEvents.touchUpInside.rawValue | UIControlEvents.touchUpOutside.rawValue
        slider.addTarget(self, action: #selector(printA), for: UIControlEvents(rawValue: event))
        let event2 =  UIControlEvents.touchDragInside.rawValue | UIControlEvents.touchDragOutside.rawValue
        slider.addTarget(self, action: #selector(printAB), for: UIControlEvents(rawValue: event2))
    }

    @objc private func printAB() {
        print("@@@@@@")
        delegate?.sliderDidBeginChange()
    }


    @objc private func printA() {
        print("BBBBB")
        let value = slider.value
        delegate?.sliderDidChanged(value: value, sender: self)
    }

    func updateFrame(with timeDuration: String, timeTotal: String, duration: Float) {
         currentTimeLbl.text = timeDuration
         totalTimeLbl.text = timeTotal
         slider.value = duration
    }
}

//MARK: ViewControllerDelegate
extension PlayerView: ViewControllerDelegate {

    func updatePlayerView(timeDuration: String, timeTotal: String, duration: Float) {
        updateFrame(with: timeDuration, timeTotal: timeTotal, duration: duration)
    }
}


