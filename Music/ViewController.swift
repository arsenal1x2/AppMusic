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
    func nextSong(sender: ControlView) {
        print("abc")
    }


    var audio:AVAudioPlayer = AVAudioPlayer()
    var isPlaying = false
    var timer:Timer = Timer()
    

    @IBOutlet weak var artworkView: ArtworkView!
    @IBOutlet weak var controlView: ControlView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        

        controlView.delegate = artworkView
    }
   func setupViews() {
        setupAudio()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupAudio() {
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Chi-Yeu-Minh-Em-Chau-Khai-Phong", ofType: "mp3")!))
        audio.prepareToPlay()

    }
}


