//
//  Season.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class Season{
    init(short: JSONShortSeason){
        self.airDate = short.air_date
        self.episodeCount = short.episode_count ?? 0
        self.id = short.id ?? 0
        self.name = short.name ?? ""
        self.overview = short.overview ?? ""
        self.posterPath = short.poster_path
        self.seasonNumber = short.season_number ?? 0
        
        self.episodes = []
        self._id = ""
    }
    
    init(full: JSONSeason){
        self.airDate = full.air_date
        self.episodeCount = full.episodes?.count ?? 0
        self.id = full.id ?? 0
        self.name = full.name ?? ""
        self.overview = full.overview ?? ""
        self.posterPath = full.poster_path
        self.seasonNumber = full.season_number ?? 0
        
        self.episodes = full.episodes?.flatMap({ (json) -> Episode in
            Episode(with: json)
        }) ?? []
        self._id = full._id ?? ""
    }
    
    var airDate : String?
    var episodeCount : Int
    var id : Int
    var name : String
    var overview : String
    var posterPath : String?
    var seasonNumber : Int
    
    var tvid : Int?
    
    var episodes : [Episode]
    var _id : String
    
    func loadEpisodes(onSuccess: @escaping (Season)->Void){
        TmdbWorker().getSeason(tvid: tvid!, seasonNumber: seasonNumber) { (s) in
            self.episodes = s.episodes
            for e in self.episodes{
                e.tvid = self.tvid
            }
            onSuccess(self)
        }
    }
}
