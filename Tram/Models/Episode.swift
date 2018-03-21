//
//  Episode.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class Episode{
    init(with json : JSONEpisode){
        self.airDate = json.air_date
        self.crew = json.crew ?? []
        self.episodeNumber = json.episode_number ?? 0
        self.guestStars = json.guest_stars ?? []
        self.name = json.name ?? ""
        self.overview = json.overview ?? ""
        self.id = json.id ?? 0
        self.productionCode = json.production_code
        self.seasonNumber = json.season_number ?? 0
        self.stillPath = json.still_path
        self.voteAverage = json.vote_average ?? 0
        self.voteCount = json.vote_count ?? 0
    }
    
    var airDate : String?
    var crew : [Crew]
    var episodeNumber : Int
    var guestStars : [Cast]
    var name : String
    var overview : String
    var id : Int
    var productionCode : String?
    var seasonNumber : Int
    var stillPath : String?
    var voteAverage : Double
    var voteCount : Int
    
    var tvid : Int?
    
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
