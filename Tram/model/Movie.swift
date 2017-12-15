//
//  MediaEntry.swift
//  Tram
//
//  Created by Roman Abuzyarov on 07.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit
import Parse

protocol MediaEntry{
    
}

class Movie : MediaEntry{
    var objectId = ""
    var budget = 0
    var releaseDate = Date()
    
    private let dateFormatter = DateFormatter()
    var year : String{
        get{
            return dateFormatter.string(from: releaseDate)
        }
    }
    
    var voteAverage = 0.0
    var rating : String{
        get{
            return String(Int(voteAverage*10))
        }
    }
    var tagline = ""
    var genres : [Genre] = []
    var status = ""
    var countries : [Country] = []
    var popularity = 0.0
    var imdbId = ""
    var title = ""
    var runtime = 0
    var length : String{
        get{
            let h = runtime/60
            let m = runtime - (h*60)
            return "\(h)h \(m)min"
        }
    }
    var overview = ""
    var voteCount = 0
    var revenue = 0
    var posterUrl = ""
    
    var imageUrl : String{
        get{
            return "http://image.tmdb.org/t/p/w500\(posterUrl)"
        }
    }
    
    var image = UIImage()
    
    init(pfo : PFObject){
        self.objectId = pfo.objectId!
        self.budget = pfo["budget"] as! Int
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        self.releaseDate = df.date(from: pfo["release_date"] as! String)!
        
        self.voteAverage = pfo["vote_average"] as! Double
        self.tagline = pfo["tagline"] as! String
        
        pfo.relation(forKey: "genres").query().findObjectsInBackground { (objects, error) -> Void in
            if let error = error{
                print("\(error) \(error.localizedDescription)")
                return
            }
            if let objects = objects{
                for (_, object) in objects.enumerated(){
                    self.genres.append(Genre(pfo: object))
                }
            }
        }
        
        self.status = pfo["status"] as! String
        
        pfo.relation(forKey: "countries").query().findObjectsInBackground { (objects, error) -> Void in
            if let error = error{
                print("\(error) \(error.localizedDescription)")
                return
            }
            if let objects = objects{
                for (_, object) in objects.enumerated(){
                    self.countries.append(Country(pfo: object))
                }
            }
        }
        
        self.popularity = pfo["popularity"] as! Double
        self.imdbId = pfo["imdb_id"] as! String
        self.title = pfo["title"] as! String
        self.runtime = pfo["runtime"] as! Int
        self.overview = pfo["overview"] as! String
        self.voteCount = pfo["vote_count"] as! Int
        self.revenue = pfo["revenue"] as! Int
        self.posterUrl = pfo["poster_url"] as! String
        
        dateFormatter.dateFormat = "yyyy"
        
        let url = URL(string: imageUrl)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if let im = UIImage(data: data!){
                    self.image = im
                }
            }
        }
    }
    
    //    func toPFObject() -> PFObject{
    //        let pfo = PFObject(className: "Movie")
    //        pfo.objectId! = objectId
    //        pfo["budget"] = budget
    //
    //        let df = DateFormatter()
    //        df.dateFormat = "yyyy-MM-dd"
    //        pfo["release_date"] = df.string(from: releaseDate)
    //        self.voteAverage = pfo["vote_average"] as! Double
    //        self.tagline = pfo["tagline"] as! String
    //
    //        return pfo
    //    }
}
