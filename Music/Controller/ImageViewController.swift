//
//  ImageViewController.swift
//  Music
//
//  Created by LTT on 11/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var pictureImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func loadImage(image: UIImage) {
        pictureImg.image = image
    }
}
