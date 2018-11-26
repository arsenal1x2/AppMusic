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

    func fetchTrack( complete: @escaping ( _ success: Bool, _ tracks: Tracks?, _ error: Error? )->() ) {
        Alamofire.request(Constants.API.baseURL+Constants.API.rankVN).responseJSON { (response) in
            if let error = response.error {
                complete(false,nil, error)
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: response.data!)
                let tracksObj: Tracks = Tracks.init(tracks: response.data.tracks)
                complete(true,tracksObj, nil)
                return

            } catch {
                complete(false,nil, error)
                return
            }
        }
    }
}
