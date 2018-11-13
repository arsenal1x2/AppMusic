//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var artworkView: ArtworkView!
    @IBOutlet weak var controlView: ControlView!
    let audioPlayer = AudioPlayer.sharedInstance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        controlView.delegate = artworkView
    }

    func setupViews() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


