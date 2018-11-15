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
    var title:String

    init() {
        name = ""
        singer = ""
        image = UIImage()
        title = ""
    }

    init(name: String, singer: String , image: UIImage, title: String) {
        self.name = name
        self.singer = singer
        self.image = image
        self.title = title
    }

    init? (name: String, singer: String , image: String, title: String) {
        self.name = name
        self.singer = singer
        guard let image = UIImage(named: image) else { return nil }
        self.image = image
        self.title = title
    }

    init? (data: [String : AnyObject]) {
        guard let name = data["name"] as? String else { return nil }
        guard let singer = data["singer"] as? String else { return nil }
        guard let imageName = data["nameImage"] as? String else {return nil }
        guard let image = UIImage(named: imageName) else { return nil }
        guard let title = data["title"] as? String else { return nil }
        self.title = title
        self.name = name
        self.singer = singer
        self.image = image
    }
}
