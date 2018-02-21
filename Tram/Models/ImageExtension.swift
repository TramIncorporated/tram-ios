//
//  ImageExtension.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights reserved.
//

import Foundation
import UIKit

//todo add caching

extension UIImageView{
    func setImageInBackground(url: URL?){
        DispatchQueue.global().async {
            if let url = url{
                
                if let image = ImageCache.Instance.images[url]{
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    return
                }
                
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                if let data = data{
                    DispatchQueue.main.async {
                        if let im = UIImage(data: data){
                            ImageCache.Instance.images[url] = im
                            self.image = im
                        }
                    }
                }
                
            }
        }
    }
}

class ImageCache{
    private init(){}
    static let Instance = ImageCache()
    var images : [URL : UIImage] = [:]
}
