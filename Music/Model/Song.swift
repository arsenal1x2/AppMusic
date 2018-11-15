//
//  Song.swift
//  Music
//
//  Created by LTT on 11/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class Song {
    var name:String
    var singer:String
    var image:UIImage

    init() {
        name = ""
        singer = ""
        image = UIImage()
    }

    init(name: String, singer: String , image: UIImage) {
        self.name = name
        self.singer = singer
        self.image = image
    }

    init? (data: [String : AnyObject]) {
        guard let name = data["name"] as? String else { return nil }
        guard let singer = data["singer"] as? String else { return nil }
        guard let imageName = data["nameImage"] as? String else {return nil}
        self.name = name
        self.singer = singer
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        self.image = image
    }

}
