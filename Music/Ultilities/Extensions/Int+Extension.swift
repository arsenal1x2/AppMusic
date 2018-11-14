//
//  Int+Extension.swift
//  Music
//
//  Created by LTT on 11/14/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

extension Int {
    static func convertToTimeString(time: TimeInterval) -> String{
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        var durationTime = ""
        if (second < 10 && minute < 10) {
            durationTime = "0\(minute):0\(second) "
        } else {
            if second < 10 {
                durationTime = "\(minute):0\(second) "
            } else if minute < 10 {
                durationTime = "0\(minute):\(second) "
            } else {
                durationTime = "\(minute):\(second) "
            }
        }
        return durationTime
    }
}
