//
//  PlayerView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class PlayerView: UIView {

    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var totalTimeLbl: UILabel!
    @IBOutlet weak var slider: UISlider!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupSlider()

    }
    private func setupSlider() {
        slider.setThumbImage(UIImage(named: "icons8-record"), for: .normal)
        slider.setThumbImage(UIImage(named: "icons8-record"), for: .highlighted)
        //slider.maximumValue = Float(audio.duration)
    }

}
