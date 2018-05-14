//
//  Episode.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Episode : Hashable{
    struct EpisodeJSONKeys {
        static let airDate = JSONKeys.airDate
        static let crew = JSONKeys.crew
        static let episodeNumber = JSONKeys.episodeNumber
        static let guestStars = JSONKeys.guestStars
        static let name = JSONKeys.name
        static let overview = JSONKeys.overview
        static let id = JSONKeys.id
        static let productionCode = JSONKeys.productionCode
        static let seasonNumber = JSONKeys.seasonNumber
        static let stillPath = JSONKeys.stillPath
        static let voteAverage = JSONKeys.voteAverage
        static let voteCount = JSONKeys.voteCount
    }
    
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
    
    var hashValue: Int
    
    init(json : JSON, tvid: Int){
        self.tvid = tvid
        
        self.airDate = json[EpisodeJSONKeys.airDate].stringNilIfEmpty
        self.crew = json[EpisodeJSONKeys.crew].arrayValue.map { Crew(json: $0) }
        self.episodeNumber = json[EpisodeJSONKeys.episodeNumber].intValue
        self.guestStars = json[EpisodeJSONKeys.guestStars].arrayValue.map { Cast(json: $0) }
        self.name = json[EpisodeJSONKeys.name].stringValue
        self.overview = json[EpisodeJSONKeys.overview].stringNilIfEmpty
        self.id = json[EpisodeJSONKeys.id].intValue
        self.productionCode = json[EpisodeJSONKeys.productionCode].stringNilIfEmpty
        self.seasonNumber = json[EpisodeJSONKeys.seasonNumber].intValue
        self.stillPath = json[EpisodeJSONKeys.stillPath].stringNilIfEmpty
        self.voteAverage = json[EpisodeJSONKeys.voteAverage].doubleValue
        self.voteCount = json[EpisodeJSONKeys.voteCount].intValue
        
        self.hashValue = json[EpisodeJSONKeys.id].intValue
    }
    
    var airDate : String?
    var crew : [Crew]
    var episodeNumber : Int
    var guestStars : [Cast]
    var name : String
    var overview : String?
    var id : Int
    var productionCode : String?
    var seasonNumber : Int
    var stillPath : String?
    var voteAverage : Double
    var voteCount : Int
    
    var tvid : Int
    
    private var date : Date?{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            if let airDate = airDate, let date = dateFormatter.date(from: airDate){
                return date
            }
            return nil
        }
    }
    
    func dateString(format: String) -> String{
        let dateF = DateFormatter()
        dateF.dateFormat = format
        if let date = date{
            return dateF.string(from: date)
        }
        return ""
    }
}
