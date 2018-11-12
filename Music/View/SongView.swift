//
//  SongView.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class SongView: UIView {

    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("SongView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    }

}
