//
//  UIView + Extension.swift
//  Music
//
//  Created by LTT on 11/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

extension UIView {

    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return }
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let contentView =  nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
