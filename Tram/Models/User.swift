//
//  User.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class User{
    var handle : String?
    var name : String?
    
    var movieWatchlist : [Movie]?
    var movieWatched : [Movie]?
    
    var showWatchlist: [TVShow]?
    var showWatched: [TVShow]?
    
    var showWatchedDictionary: [String:[String]]?
    
    var bars : [(progressText: String, title: String, progress: Float)]{
        get{
            var res = [(progressText: String, title: String, progress: Float)]()
            
            if let watchlist = movieWatchlist, let watched = movieWatched{
                let total = watched.count+watchlist.count
                let current = watched.count
                
                res.append((progressText: "\(current) out of \(total)", title: "movies", progress: Float(current)/Float(total)))
            }
            
            if let watchlist = showWatchlist, let watched = showWatched{
                let total = watched.count+watchlist.count
                let current = watched.count
                
                res.append((progressText: "\(current) out of \(total)", title: "tv shows", progress: Float(current)/Float(total)))
            }
            
            return res
        }
    }
}
