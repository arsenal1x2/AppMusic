//
//  DataService.swift
//  Music
//
//  Created by LTT on 11/20/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import Alamofire

struct DataService {
    static let shared = DataService()
    private var trackUrl = "https://music-api-kp.herokuapp.com/ranks/songs/nhac-viet"

    func fetchTrack( complete: @escaping ( _ success: Bool, _ tracks: Tracks?, _ error: Error? )->() ) {
        Alamofire.request(trackUrl).responseJSON { (response) in
            if let error = response.error {
                complete(false,nil, error)
                return
            }
            var tracks: [Track] = [Track]()
            if let json = response.value as? [String: AnyObject]{
                if  let data = json["data"] as? [String: AnyObject] {
                    if let res = data["tracks"] as? [[String:AnyObject]] {
                        for item in res {
                            guard let track = Track(data: item) else { return }
                            tracks.append(track)
                        }
                    }
                }
                let tracksObj: Tracks = Tracks.init(tracks: tracks)
                complete(true,tracksObj, nil)
                return
            }
        }
    }
}
