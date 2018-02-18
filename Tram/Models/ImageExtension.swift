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
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if let data = data{
                DispatchQueue.main.async {
                    if let im = UIImage(data: data){
                        self.image = im
                    }
                }
            }
        }
    }
}
