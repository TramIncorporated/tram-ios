//
//  TVShow.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class TVShow{
    init(with json: JSONTVShow){
        self.backdropPath = json.backdrop_path
        self.createdBy = json.created_by?.flatMap({ (json) -> Creator in
            Creator(with: json)
        }) ?? []
        self.episodeRunTime = json.episode_run_time ?? []
        
        self.firstAirDate = json.first_air_date
        self.genres = json.genres?.flatMap({ (json) -> Genre in
            Genre(from: json)
        }) ?? []
        self.homepage = json.homepage
        self.id = json.id ?? 0
        self.inProduction = json.in_production ?? false
        self.languages = json.languages ?? []
        self.lastAirDate = json.last_air_date
        self.name = json.name ?? ""
        self.networks = json.networks?.flatMap({ (json) -> Network in
            Network(with: json)
        }) ?? []
        self.numberOfEpisodes = json.number_of_episodes ?? 0
        self.numberOfSeasons = json.number_of_seasons ?? 0
        self.originCountry = json.origin_country ?? []
        self.originalLanguage = json.original_language ?? ""
        self.originalName = json.original_name ?? ""
        self.overview = json.overview ?? ""
        self.popularity = json.popularity ?? 0
        self.posterPath = json.poster_path
        self.productionCompanies = json.production_companies?.flatMap({ (json) -> Company in
            Company(from: json)
        }) ?? []
        let id = json.id ?? 0
        self.seasons = json.seasons?.flatMap({ (json) -> Season in
            let s = Season(short: json)
            s.tvid = id
            return s
        }) ?? []
        self.status = json.status ?? ""
        self.type = json.type ?? ""
        self.voteAverage = json.vote_average ?? 0
        self.voteCount = json.vote_count ?? 0
        self.cast = json.credits?.cast ?? []
        self.crew = json.credits?.crew ?? []
        
        initDetails()
    }
    
    var details : [(String, String)] = []
    
    func initDetails(){
        if status != ""{
            let key = "Status"
            let value = "\(status)"
            details.append((key, value))
        }
        if let date = firstDate{
            let df = DateFormatter()
            df.dateFormat = "dd.mm.yyyy"
            details.append(("First air date", df.string(from: date)))
        }
        if let date = lastDate{
            let df = DateFormatter()
            df.dateFormat = "dd.mm.yyyy"
            details.append(("Last air date", df.string(from: date)))
        }
        if createdBy.count > 0{
            let key = "Created by"
            let value = createdBy.flatMap { $0.name }.toBulletList()
            details.append((key, value))
        }
        if let homepage = homepage, homepage != ""{
            let key = "Homepage"
            let value = "\(homepage)"
            details.append((key, value))
        }
        if originalName != ""{
            let key = "Original title"
            let value = "\(originalName)"
            details.append((key, value))
        }
        if networks.count > 0{
            let key = "Networks"
            let value = networks.flatMap { $0.name }.toBulletList()
            details.append((key, value))
        }
        if productionCompanies.count > 0{
            let key = "Companies"
            let value = productionCompanies.flatMap { $0.name }.toBulletList()
            details.append((key, value))
        }
    }
    
    var backdropPath : String?
    var createdBy : [Creator]
    var episodeRunTime : [Int]
    var firstAirDate : String?
    var genres : [Genre]
    var homepage : String?
    var id : Int
    var inProduction : Bool
    var languages : [String]
    var lastAirDate : String?
    var name : String
    var networks : [Network]
    var numberOfEpisodes : Int
    var numberOfSeasons : Int
    var originCountry : [String]
    var originalLanguage : String
    var originalName : String
    var overview : String
    var popularity : Double
    var posterPath : String?
    var productionCompanies : [Company]
    var seasons : [Season]
    var status : String
    var type : String
    var voteAverage : Double
    var voteCount : Int
    var cast : [Cast]
    var crew : [Crew]
    
    private var firstDate : Date?{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let releaseDate = firstAirDate, let date = dateFormatter.date(from: releaseDate){
                return date
            }
            return nil
        }
    }
    
    private var lastDate : Date?{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let releaseDate = lastAirDate, let date = dateFormatter.date(from: releaseDate){
                return date
            }
            return nil
        }
    }
    
    var year : String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let date = firstDate{
                dateFormatter.dateFormat = "yyyy"
                return dateFormatter.string(from: date)
            }
            return "Year not available"
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
    
    var rating : String{
        get{
            return "\(Int(voteAverage*10))%"
        }
    }
}

class Creator{
    init(with json: JSONCreator){
        self.id = json.id ?? 0
        self.name = json.name ?? ""
        self.gender = json.gender ?? 0
        self.profilePath = json.profile_path
    }
    
    var id : Int
    var name : String
    var gender : Int
    var profilePath : String?
}

class Network{
    init(with json: JSONNetwork){
        self.name = json.name ?? ""
        self.id = json.id ?? 0
        self.logoPath = json.logo_path
        self.originCountry = json.origin_country
    }
    
    var name : String
    var id : Int
    var logoPath : String?
    var originCountry : String?
}
