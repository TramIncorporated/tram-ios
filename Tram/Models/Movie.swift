//
//  Movie.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights detailserved.
//

import Foundation
import SwiftyJSON

class Movie {
    struct MovieJSONKeys{
        static let adult = JSONKeys.adult
        static let backdropPath = JSONKeys.backdropPath
        static let belongsToCollection = JSONKeys.belongsToCollection
        static let budget = JSONKeys.budget
        static let genres = JSONKeys.genres
        static let homepage = JSONKeys.homepage
        static let id = JSONKeys.id
        static let imdbId = JSONKeys.imdbId
        static let originalLanguage = JSONKeys.originalLanguage
        static let originalTitle = JSONKeys.originalTitle
        static let overview = JSONKeys.overview
        static let popularity = JSONKeys.popularity
        static let posterPath = JSONKeys.posterPath
        static let productionCompanies = JSONKeys.productionCompanies
        static let productionCountries = JSONKeys.productionCountries
        static let releaseDate = JSONKeys.releaseDate
        static let revenue = JSONKeys.revenue
        static let runtime = JSONKeys.runtime
        static let spokenLanguages = JSONKeys.spokenLanguages
        static let status = JSONKeys.status
        static let tagline = JSONKeys.tagline
        static let title = JSONKeys.title
        static let video = JSONKeys.video
        static let voteAverage = JSONKeys.voteAverage
        static let voteCount = JSONKeys.voteCount
        
        static let credits = JSONKeys.credits
        static let cast = JSONKeys.cast
        static let crew = JSONKeys.crew
    }
    
    init(json: JSON){
        adult = json[MovieJSONKeys.adult].boolValue
        backdropPath = json[MovieJSONKeys.backdropPath].stringNilIfEmpty
        if json[MovieJSONKeys.belongsToCollection] != JSON.null {
            belongsToCollection = Collection(json: json[MovieJSONKeys.belongsToCollection])
        }
        budget = json[MovieJSONKeys.budget].intValue
        genres = json[MovieJSONKeys.genres].arrayValue.map { Genre(json: $0) }
        homepage = json[MovieJSONKeys.homepage].stringNilIfEmpty
        id = json[MovieJSONKeys.id].intValue
        
        imdbId = json[MovieJSONKeys.imdbId].stringNilIfEmpty
        originalLanguage = json[MovieJSONKeys.originalLanguage].stringValue
        originalTitle = json[MovieJSONKeys.originalTitle].stringValue
        overview = json[MovieJSONKeys.overview].stringNilIfEmpty
        popularity = json[MovieJSONKeys.popularity].doubleValue
        posterPath = json[MovieJSONKeys.posterPath].stringNilIfEmpty
        companies = json[MovieJSONKeys.productionCompanies].arrayValue.map { Company(json: $0) }
        countries = json[MovieJSONKeys.productionCountries].arrayValue.map { Country(json: $0) }
        releaseDate = json[MovieJSONKeys.releaseDate].stringValue
        revenue = json[MovieJSONKeys.revenue].intValue
        runtime = json[MovieJSONKeys.runtime].int
        spokenLanguages = json[MovieJSONKeys.spokenLanguages].arrayValue.map { Language(json: $0) }
        status = MovieStatus(rawValue: json[MovieJSONKeys.status].stringValue)
        tagline = json[MovieJSONKeys.tagline].stringNilIfEmpty
        title = json[MovieJSONKeys.title].stringValue
        voteAverage = json[MovieJSONKeys.voteAverage].doubleValue
        voteCount = json[MovieJSONKeys.voteCount].intValue
        
        crew = json[MovieJSONKeys.credits][MovieJSONKeys.crew].arrayValue.map { Crew(json: $0) }
        cast = json[MovieJSONKeys.credits][MovieJSONKeys.cast].arrayValue.map { Cast(json: $0) }
        
        initDetails()
    }
    
    var crew: [Crew]
    var cast: [Cast]
    
    var adult : Bool
    var backdropPath : String?
    var belongsToCollection : Collection?
    var budget : Int
    var genres : [Genre]
    var homepage : String?
    var id : Int
    var imdbId : String?
    var originalLanguage : String
    var originalTitle : String
    var overview : String?
    var popularity : Double
    var posterPath : String?
    var companies : [Company]
    var countries : [Country]
    var releaseDate : String
    var revenue : Int
    var runtime : Int?
    var spokenLanguages : [Language]

    enum MovieStatus : String {
        case rumored = "Rumored"
        case planned = "Planned"
        case inProduction = "In Production"
        case postProduction = "Post Production"
        case released = "Released"
        case canceled = "Canceled"
    }
    var status : MovieStatus?
    
    var tagline : String?
    var title : String
    var voteAverage : Double
    var voteCount : Int
    
    var details : [(String, String)] = []
    
    func initDetails(){
        if let status = status{
            let key = "Status"
            let value = "\(status.rawValue)"
            details.append((key, value))
        }
        if let date = date{
            let df = DateFormatter()
            df.dateFormat = "dd.mm.yyyy"
            details.append(("Release date", df.string(from: date)))
        }
        if budget != 0{
            let key = "Budget"
            let value = budget.toDollarString()
            details.append((key, value))
        }
        if revenue != 0{
            let key = "Revenue"
            let value = revenue.toDollarString()
            details.append((key, value))
        }
        if let homepage = homepage, homepage != ""{
            let key = "Homepage"
            let value = "\(homepage)"
            details.append((key, value))
        }
        if originalTitle != "" && originalTitle != title{
            let key = "Original title"
            let value = "\(originalTitle)"
            details.append((key, value))
        }
        if spokenLanguages.count > 0{
            let key = "Languages"
            let value = spokenLanguages.map { $0.name }.toBulletList()
            details.append((key, value))
        }
        if companies.count > 0{
            let key = "Companies"
            let value = companies.map { $0.name }.toBulletList()
            details.append((key, value))
        }
        if countries.count > 0{
            let key = "Countries"
            let value = countries.map { $0.name }.toBulletList()
            details.append((key, value))
        }
    }
    
    private var date : Date?{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let date = dateFormatter.date(from: releaseDate){
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
            return "\(Int(voteAverage*10))%"
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
}
