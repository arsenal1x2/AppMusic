//
//  ListSong.swift
//  Music
//
//  Created by LTT on 11/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

class ListSong {
    var listSong: [Song]
    var indexOfConcurentSong: Int = 0

    init() {
        var tmp:[Song] = [Song]()
        let listTitle = ["Chỉ yêu mình em", "Trót yêu", "Chiều hôm ấy", "Đổi thay", "Tim anh thắt lại"]
        let listName = [
                        "Chi-Yeu-Minh-Em-Chau-Khai-Phong",
                        "TrotYeu-TrungQuanIdol-2967468",
                        "ChieuHomAy-JayKii-5076088",
                        "DoiThay-HoQuangHieu-4563803",
                        "TimAnhThatLai-HoQuangHieu-5664511"
                       ]
        let listSinger = ["Châu Khải Phong", "Trung Quân", "Jaykil", "Hồ Quang Hiếu", "Hồ Quang Hiếu"]
        let listImgName = [
                                Constants.Image.arsenal,
                                Constants.Image.picture,
                                Constants.Image.sontung,
                                Constants.Image.arsenal,
                                Constants.Image.picture
                          ]
        for index in 0 ... listName.count - 1 {
            let name = listName[index]
            let title = listTitle[index]
            let image = listImgName[index]
            let singer = listSinger[index]

            let song = Song(name: name, singer: singer, image: image, title: title)
            tmp.append(song!)
        }
        self.listSong = tmp
    }

    func Next() -> Song {
        if indexOfConcurentSong == listSong.count - 1 {
            indexOfConcurentSong = 0
        } else {
            indexOfConcurentSong = indexOfConcurentSong + 1
        }
        return listSong[indexOfConcurentSong]
    }

    func Previous() -> Song {
        if indexOfConcurentSong == 0 {
            indexOfConcurentSong = listSong.count - 1
        } else {
            indexOfConcurentSong = indexOfConcurentSong - 1
        }
        return listSong[indexOfConcurentSong]
    }
}
