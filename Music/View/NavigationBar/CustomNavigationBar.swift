//
//  CustomNavigationBar.swift
//  Music
//
//  Created by LTT on 11/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

protocol CustomNavigationBarDelegate: class {
    func navigationbar(_ navigationbar: CustomNavigationBar, didSelectLeftButton: UIButton)
    func navigationbar(_ navigationbar: CustomNavigationBar, didSelectRightButton: UIButton)
}

class CustomNavigationBar: UIView {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rightItemBtn: UIButton!
    @IBOutlet weak var leftItemBtn: UIButton!
    weak var delegate:CustomNavigationBarDelegate?

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

    @IBAction func clickLeftItemBtn(_ sender: Any) {
        delegate?.navigationbar(self, didSelectLeftButton: leftItemBtn)
    }


    @IBAction func clickRighBtn(_ sender: Any) {
        delegate?.navigationbar(self, didSelectRightButton: rightItemBtn)
    }

}
