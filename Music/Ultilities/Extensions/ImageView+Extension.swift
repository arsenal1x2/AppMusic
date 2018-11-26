//
//  ImageView+Extension.swift
//  Music
//
//  Created by LTT on 11/22/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        self.sd_setImage(with: url!) { (image, error, type, url) in
            imageCache.setObject(image!, forKey: urlString as AnyObject)
            self.image = image
        }
    }
}
