//
//  ImageExtension.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheManager{
    private static let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        cache.name = "ImageCacheManager"
        
        // Max 20 images in memory.
        cache.countLimit = 20
        
        // Max 10MB used.
        cache.totalCostLimit = 10 * 1024 * 1024
        
        return cache
    }()
    
    static func getImageInBackground(url: URL?, onComplete: @escaping (UIImage)->Void){
        DispatchQueue.global().async {
            if let url = url{
                if let image = ImageCacheManager.imageCache.object(forKey: url.absoluteString as NSString){
                    DispatchQueue.main.async {
                        onComplete(image)
                    }
                    return
                }
                
                let data = try? Data(contentsOf: url)
                if let data = data{
                    if let im = UIImage(data: data){
                        DispatchQueue.main.async {
                            ImageCacheManager.imageCache.setObject(im, forKey: url.absoluteString as NSString)
                            onComplete(im)
                        }
                    }
                }
            }
        }
    }
}
