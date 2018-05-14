//
//  TVShow.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class TVShow{
    struct TVShowJSONKeys {
        static let backdropPath = JSONKeys.backdropPath
        static let createdBy = JSONKeys.createdBy
        static let episodeRunTime = JSONKeys.episodeRunTime
        static let firstAirDate = JSONKeys.firstAirDate
        static let genres = JSONKeys.genres
        static let homepage = JSONKeys.homepage
        static let id = JSONKeys.id
        static let inProduction = JSONKeys.inProduction
        static let languages = JSONKeys.languages
        static let lastAirDate = JSONKeys.lastAirDate
        static let name = JSONKeys.name
        static let networks = JSONKeys.networks
        static let numberOfEpisodes = JSONKeys.numberOfEpisodes
        static let numberOfSeasons = JSONKeys.numberOfSeasons
        static let originCountry = JSONKeys.originCountry
        static let originalLanguage = JSONKeys.originalLanguage
        static let originalName = JSONKeys.originalName
        static let overview = JSONKeys.overview
        static let popularity = JSONKeys.popularity
        static let posterPath = JSONKeys.posterPath
        static let productionCompanies = JSONKeys.productionCompanies
        static let seasons = JSONKeys.seasons
        static let status = JSONKeys.status
        static let type = JSONKeys.type
        static let voteAverage = JSONKeys.voteAverage
        static let voteCount = JSONKeys.voteCount
        
        static let credits = JSONKeys.credits
        static let cast = JSONKeys.cast
        static let crew = JSONKeys.crew
    }
    
    init(json: JSON){
        self.backdropPath = json[TVShowJSONKeys.backdropPath].stringNilIfEmpty
        self.createdBy = json[TVShowJSONKeys.createdBy].arrayValue.map { Creator(json: $0) }
        self.episodeRunTime = json[TVShowJSONKeys.episodeRunTime].arrayValue.map { $0.intValue }
        self.firstAirDate = json[TVShowJSONKeys.firstAirDate].stringNilIfEmpty
        self.genres = json[TVShowJSONKeys.genres].arrayValue.map { Genre(json: $0) }
        self.homepage = json[TVShowJSONKeys.homepage].stringNilIfEmpty
        self.id = json[TVShowJSONKeys.id].intValue
        self.inProduction = json[TVShowJSONKeys.inProduction].boolValue
        self.languages = json[TVShowJSONKeys.languages].arrayValue.map { $0.stringValue }
        self.lastAirDate = json[TVShowJSONKeys.lastAirDate].stringNilIfEmpty
        self.name = json[TVShowJSONKeys.name].stringValue
        self.networks = json[TVShowJSONKeys.networks].arrayValue.map { Network(fromTVShow: $0) }
        self.numberOfEpisodes = json[TVShowJSONKeys.numberOfEpisodes].intValue
        self.numberOfSeasons = json[TVShowJSONKeys.numberOfSeasons].intValue
        self.originCountry = json[TVShowJSONKeys.originCountry].arrayValue.map { $0.stringValue }
        self.originalLanguage = json[TVShowJSONKeys.originalLanguage].stringValue
        self.originalName = json[TVShowJSONKeys.originalName].stringValue
        self.overview = json[TVShowJSONKeys.overview].stringNilIfEmpty
        self.popularity = json[TVShowJSONKeys.popularity].doubleValue
        self.posterPath = json[TVShowJSONKeys.posterPath].stringNilIfEmpty
        self.productionCompanies = json[TVShowJSONKeys.productionCompanies].arrayValue.map { Company(json: $0) }
        let id = json[TVShowJSONKeys.id].intValue
        self.seasons = json[TVShowJSONKeys.seasons].arrayValue.map { Season(fromTVShow: $0, tvid: id) }
        self.status = TVShowStatus(rawValue: json[TVShowJSONKeys.status].stringValue)
        self.type = TVShowType(rawValue: json[TVShowJSONKeys.type].stringValue)
        self.voteAverage = json[TVShowJSONKeys.voteAverage].doubleValue
        self.voteCount = json[TVShowJSONKeys.voteCount].intValue
        self.cast = json[TVShowJSONKeys.credits][TVShowJSONKeys.cast].arrayValue.map { Cast(json: $0) }
        self.crew = json[TVShowJSONKeys.credits][TVShowJSONKeys.crew].arrayValue.map { Crew(json: $0) }

        initDetails()
    }
    
    var details : [(String, String)] = []
    
    func initDetails(){
        if let status = status{
            let key = "Status"
            let value = "\(status.rawValue)"
            details.append((key, value))
        }
        if let type = type {
            let key = "Type"
            let value = "\(type.rawValue)"
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
            let value = createdBy.map { $0.name }.toBulletList()
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
            let value = networks.map { $0.name }.toBulletList()
            details.append((key, value))
        }
        if productionCompanies.count > 0{
            let key = "Companies"
            let value = productionCompanies.map { $0.name }.toBulletList()
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
    var overview : String?
    var popularity : Double
    var posterPath : String?
    var productionCompanies : [Company]
    var seasons : [Season]
    
    enum TVShowStatus : String {
        case returningSeries = "Returning Series"
        case planned = "Planned"
        case inProduction = "In Production"
        case ended = "Ended"
        case canceled = "Canceled"
        case pilot = "Pilot"
    }
    var status : TVShowStatus?
    
    enum TVShowType : String {
        case scripted = "Scripted"
        case reality = "Reality"
        case documentary = "Documentary"
        case news = "News"
        case talkShow = "Talk Show"
        case miniseries = "Miniseries"
    }
    var type : TVShowType?
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
    
    var imageUrl : URL?{
        get{
            if let posterPath = posterPath{
                return URL(string: "http://image.tmdb.org/t/p/w185\(posterPath)")
            }
            return nil
        }
    }
    
    var stars : String{
        get{
            return cast
                .sorted { $0.order < $1.order }
                .prefix(2)
                .map{ $0.name }
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
    struct CreatorJSONKeys{
        static let id = JSONKeys.id
        static let name = JSONKeys.name
        static let gender = JSONKeys.gender
        static let profilePath = JSONKeys.profilePath
    }
    
    init(json: JSON){
        self.id = json[CreatorJSONKeys.id].intValue
        self.name = json[CreatorJSONKeys.name].stringValue
        self.gender = Gender(json[CreatorJSONKeys.gender].int)
        self.profilePath = json[CreatorJSONKeys.profilePath].stringNilIfEmpty
    }
    
    var id : Int
    var name : String
    var gender : Gender
    var profilePath : String?
}

class Network{
    struct NetworkJSONKeys {
        static let name = JSONKeys.name
        static let id = JSONKeys.id
        static let logoPath = JSONKeys.logoPath
        static let originCountry = JSONKeys.originCountry
        static let headquarters = JSONKeys.headquarters
    }
    
    convenience init(json: JSON){
        self.init(fromTVShow: json)
        
        self.headquarters = json[NetworkJSONKeys.headquarters].stringNilIfEmpty
    }
    
    init(fromTVShow json: JSON){
        self.name = json[NetworkJSONKeys.name].stringValue
        self.id = json[NetworkJSONKeys.id].intValue
        self.logoPath = json[NetworkJSONKeys.logoPath].stringNilIfEmpty
        self.originCountry = json[NetworkJSONKeys.originCountry].stringNilIfEmpty
    }
    
    var name : String
    var id : Int
    var logoPath : String?
    var originCountry : String?
    var headquarters : String?
}
