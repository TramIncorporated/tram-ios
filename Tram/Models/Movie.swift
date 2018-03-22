//
//  Movie.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights detailserved.
//

import Foundation

class Movie {
    init(with json: JSONMovie){
        adult = json.adult
        budget = json.budget ?? 0
        genres = json.genres?.flatMap({ (json) -> Genre in
            return Genre(from: json)
        }) ?? []
        homepage = json.homepage
        id = json.id ?? -1
        originalTitle = json.original_title
        overview = json.overview
        popularity = json.popularity
        posterPath = json.poster_path
        companies = json.production_companies?.flatMap({ (json) -> Company in
            return Company(from: json)
        }) ?? []
        countries = json.production_countries?.flatMap({ (json) -> Country in
            return Country(from: json)
        }) ?? []
        releaseDate = json.release_date
        revenue = json.revenue
        runtime = json.runtime
        spokenLanguages = json.spoken_languages?.flatMap({ (json) -> Language in
            return Language(from: json)
        }) ?? []
        status = json.status
        tagline = json.tagline
        title = json.title ?? ""
        voteAverage = json.vote_average
        voteCount = json.vote_count
        
        crew = json.credits?.crew ?? []
        cast = json.credits?.cast ?? []
        
        initDetails()
    }
    
    var crew: [Crew]
    var cast: [Cast]
    
    var adult : Bool?
    var budget : Int?
    var genres : [Genre]
    var homepage : String?
    var id : Int
    var originalTitle : String?
    var overview : String?
    var popularity : Double?
    var posterPath : String?
    var companies : [Company]
    var countries : [Country]
    var releaseDate : String?
    var revenue : Int?
    var runtime : Int?
    var spokenLanguages : [Language]
    var status : String?
    var tagline : String?
    var title : String
    var voteAverage : Double?
    var voteCount : Int?
    
    var details : [(String, String)] = []
    
    func initDetails(){
        if let status = status{
            let key = "Status"
            let value = "\(status)"
            details.append((key, value))
        }
        if let date = date{
            let df = DateFormatter()
            df.dateFormat = "dd.mm.yyyy"
            details.append(("Release date", df.string(from: date)))
        }
        if let budget = budget, budget != 0{
            let key = "Budget"
            let value = budget.toDollarString()
            details.append((key, value))
        }
        if let revenue = revenue, revenue != 0{
            let key = "Revenue"
            let value = revenue.toDollarString()
            details.append((key, value))
        }
        if let homepage = homepage{
            let key = "Homepage"
            let value = "\(homepage)"
            details.append((key, value))
        }
        if let originalTitle = originalTitle{
            let key = "Original title"
            let value = "\(originalTitle)"
            details.append((key, value))
        }
        if spokenLanguages.count > 0{
            let key = "Languages"
            let value = spokenLanguages.flatMap({ (l) -> String in
                return l.name
            }).toBulletList()
            details.append((key, value))
        }
        if companies.count > 0{
            let key = "Companies"
            let value = companies.flatMap({ (c) -> String in
                return c.name
            }).toBulletList()
            details.append((key, value))
        }
        if countries.count > 0{
            let key = "Countries"
            let value = countries.flatMap({ (c) -> String in
                return c.name
            }).toBulletList()
            details.append((key, value))
        }
    }
    
    private var date : Date?{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let releaseDate = releaseDate, let date = dateFormatter.date(from: releaseDate){
                return date
            }
            return nil
        }
    }
    
    var year : String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let date = date{
                dateFormatter.dateFormat = "yyyy"
                return dateFormatter.string(from: date)
            }
            return "Year not available"
        }
    }
    
    var rating : String{
        get{
            if let voteAverage = voteAverage{
                return "\(Int(voteAverage*10))%"
            }
            return "Rating not available"
        }
    }
    
    var length : String{
        get{
            if let runtime = runtime{
                let h = runtime/60
                let m = runtime - (h*60)
                return "\(h)h \(m)min"
            }
            return "Runtime not available"
        }
    }
    
    var imageUrl : String{
        get{
            if let posterPath = posterPath{
                return "http://image.tmdb.org/t/p/w185\(posterPath)"
            }
            return ""
        }
    }
    
    var stars : String{
        get{
            return cast
                .sorted { $0.order < $1.order }
                .prefix(2)
                .flatMap{ $0.name }
                .joined(separator: ", ")
        }
    }
}
