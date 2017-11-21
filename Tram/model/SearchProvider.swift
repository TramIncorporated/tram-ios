//
//  SearchProvider.swift
//  Tram
//
//  Created by Roman Abuzyarov on 19.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit

class SearchProvider{
    func getEntries(for query: String) -> [SearchEntry] {
        return base.filter { (s) -> Bool in
            s.title.starts(with: query)
        }
    }
    let base = [
        SearchEntry(posterImage: UIImage(named: "/Users/romanabuzyarov/Pictures/Caroline/photo_2017-05-04_18-09-38.jpg")!, title: "roma"),
        SearchEntry(posterImage: UIImage(named: "/Users/romanabuzyarov/Pictures/Caroline/photo_2017-05-04_18-09-38.jpg")!, title: "r"),
        SearchEntry(posterImage: UIImage(named: "/Users/romanabuzyarov/Pictures/Caroline/photo_2017-05-04_18-09-38.jpg")!, title: "ro"),
        SearchEntry(posterImage: UIImage(named: "/Users/romanabuzyarov/Pictures/Caroline/photo_2017-05-04_18-09-38.jpg")!, title: "rom"),
    ]
}

class SearchEntry{
    init(posterImage: UIImage, title: String){
        self.posterImage = posterImage
        self.title = title
    }
    
    let posterImage : UIImage
    let title : String
}
