//
//  Track.swift
//  Music
//
//  Created by LTT on 11/21/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import Alamofire

class Track: NSObject, Codable {
    let avatar: String
    let id: String
    let lyric: String
    let name: String
    let singer: String
    let url: String

    init? (data: [String: AnyObject]) {
        guard  let avatar = data["avatar"] as? String else { return nil }
        guard let id = data["id"] as? String else { return nil }
        guard let lyric = data["lyric"] as? String else { return nil }
        guard let name = data["name"] as? String else { return nil }
        guard let singer = data["singer"] as? String else { return nil }
        guard let url = data["url"] as? String else { return nil }
        self.avatar = avatar
        self.id = id
        self.lyric = lyric
        self.name = name
        self.singer = singer
        self.url = url
    }

    static func ==(lhs: Track, rhs: Track) -> Bool {
        return lhs.name == rhs.name
    }

    static func <(lhs: Track, rhs: Track) -> Bool {
        return lhs.name < rhs.name
    }
}




