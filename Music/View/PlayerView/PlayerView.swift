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
    }

    @IBAction func sliderChanged(_ sender: Any) {
        let value = slider.value
        delegate?.sliderDidChanged(value: value, sender: self)
    }

    private func commonInit() {
        loadNib()
        setupSlider()
    }
    private func setupSlider() {
        slider.setThumbImage(UIImage(named: icon.slider), for: .normal)
        slider.setThumbImage(UIImage(named: icon.slider), for: .highlighted)
    }

    func updateFrame(with timeDuration: String, timeTotal: String, duration: Float) {
         currentTimeLbl.text = timeDuration
         totalTimeLbl.text = timeTotal
         slider.value = duration
    }
}


