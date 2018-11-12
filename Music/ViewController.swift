//
//  ViewController.swift
//  Music
//
//  Created by LTT on 11/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import ImageSlideshow
import AVFoundation
class ViewController: UIViewController {

    var audio:AVAudioPlayer = AVAudioPlayer()
    var isPlaying = false
    var timer:Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
   @IBOutlet weak var controlView: ControlView!
    
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

