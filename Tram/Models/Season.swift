//
//  Season.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Season{
    struct SeasonJSONKeys {
        static let _id = JSONKeys._id
        static let airDate = JSONKeys.airDate
        static let episodeCount = JSONKeys.episodeCount
        static let episodes = JSONKeys.episodes
        static let name = JSONKeys.name
        static let overview = JSONKeys.overview
        static let id = JSONKeys.id
        static let posterPath = JSONKeys.posterPath
        static let seasonNumber = JSONKeys.seasonNumber
    }
    
    init(fromTVShow json: JSON, tvid: Int){
        self.tvid = tvid
        
        self.airDate = json[SeasonJSONKeys.airDate].stringNilIfEmpty
        self.episodeCount = json[SeasonJSONKeys.episodeCount].intValue
        self.id = json[SeasonJSONKeys.id].intValue
        self.name = json[SeasonJSONKeys.name].stringValue
        self.overview = json[SeasonJSONKeys.overview].stringNilIfEmpty
        self.posterPath = json[SeasonJSONKeys.posterPath].stringNilIfEmpty
        self.seasonNumber = json[SeasonJSONKeys.posterPath].intValue
        
        self.episodes = []
    }
    
    init(json: JSON, tvid: Int){
        self.tvid = tvid
        
        self.airDate = json[SeasonJSONKeys.airDate].stringNilIfEmpty
        let episodes = json[SeasonJSONKeys.episodes].arrayValue.map { Episode(json: $0, tvid: tvid) }
        self.episodeCount = episodes.count
        self.episodes = episodes
        self.id = json[SeasonJSONKeys.id].intValue
        self.name = json[SeasonJSONKeys.name].stringValue
        self.overview = json[SeasonJSONKeys.overview].stringNilIfEmpty
        self.posterPath = json[SeasonJSONKeys.posterPath].stringNilIfEmpty
        self.seasonNumber = json[SeasonJSONKeys.seasonNumber].intValue
        
        self._id = json[SeasonJSONKeys._id].stringNilIfEmpty
    }
    
    var airDate : String?
    var episodeCount : Int
    var id : Int
    var name : String
    var overview : String?
    var posterPath : String?
    var seasonNumber : Int
    var tvid : Int
    
    var episodes : [Episode]
    var _id : String?
    
    func loadEpisodes(onSuccess: @escaping (Season)->Void){
        TmdbWorker().getSeason(tvid: tvid, seasonNumber: seasonNumber) { (s) in
            self.episodes = s.episodes
            for e in self.episodes{
                e.tvid = self.tvid
            }
            onSuccess(self)
        }
    }
}
