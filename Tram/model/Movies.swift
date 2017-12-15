//
//  Movies
//  Tram
//
//  Created by Roman Abuzyarov on 19.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Movies{
    static let Instance = Movies()
    var movies : [Movie] = []
    func loadMovies(){
        movies.removeAll()
        let query = PFQuery(className: "Movie")
        query.cachePolicy = .networkElseCache
        query.findObjectsInBackground { (objects, error) -> Void in
            if let error = error{
                print("\(error) \(error.localizedDescription)")
                return
            }
            
            if let objects = objects{
                for (_, object) in objects.enumerated(){
                    self.movies.append(Movie(pfo: object))
                }
            }
        }
    }
}
