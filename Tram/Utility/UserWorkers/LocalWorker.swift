//
//  LocalWorker.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class LocalWorker : UserWorker{
    
    private let watchlistMovie = "watchlist_movie"
    private let watchlistShow = "watchlist_show"
    private let watchedMovie = "watched_movie"
    private let watchedShow = "watched_show"
    
    func getUser(by id: Int, onSuccess: @escaping (User) -> Void) {
        let user = User()
        user.handle = "@romikabi"
        user.name = "Roman Abuzyarov"
        
        user.showWatchedDictionary = UserDefaults.standard.dictionary(forKey: watchedShow) as? [String:[String]] ?? [:]
        
        let expected = 4
        var current = 0
        
        load(list: .Watchlist, ofUserWithId: id) { (m : [Movie]) in
            user.movieWatchlist = m
            current += 1
            if current >= expected{
                onSuccess(user)
            }
        }
        
        load(list: .Watched, ofUserWithId: id) { (m : [Movie]) in
            user.movieWatched = m
            current += 1
            if current >= expected{
                onSuccess(user)
            }
        }
        
        load(list: .Watchlist, ofUserWithId: id) { (m : [TVShow]) in
            user.showWatchlist = m
            current += 1
            if current >= expected{
                onSuccess(user)
            }
        }
        
        load(list: .Watched, ofUserWithId: id) { (m : [TVShow]) in
            user.showWatched = m
            current += 1
            if current >= expected{
                onSuccess(user)
            }
        }
    }
    
    func load(list: ListName, ofUserWithId id: Int, onSuccess: @escaping ([Movie])->Void){
        let ud = UserDefaults.standard
        var key : String
        switch list {
        case .Watched:
            key = watchedMovie
        case .Watchlist:
            key = watchlistMovie
        }
        let list = ud.stringArray(forKey: key) ?? []
        
        let tmdb = TmdbWorker()
        
        let expectedCount = list.count
        var movies: [Movie] = []
        
        if expectedCount == 0{
            onSuccess([])
        }
        for id in list{
            if let id = Int(id){
                tmdb.getMovie(by: id, completion: { (m) in
                    movies.append(m)
                    if movies.count == expectedCount{
                        onSuccess(movies)
                    }
                })
            }
        }
    }
    
    func load(list: ListName, ofUserWithId id: Int, onSuccess: @escaping ([TVShow])->Void){
        let ud = UserDefaults.standard
        
        switch list {
        case .Watchlist:
            let key = watchlistShow
            let dictionary = ud.dictionary(forKey: key) ?? [:]
            let tmdb = TmdbWorker()
            
            let expected = dictionary.keys.count
            var shows = [TVShow]()
            if expected == 0{
                onSuccess([])
            }
            
            for (k, _) in dictionary{
                tmdb.getTVShow(by: Int(k)!, completion: { (show) in
                    let expectedS = show.seasons.count
                    var currentS = 0
                    for season in show.seasons{
                        season.loadEpisodes(onSuccess: { (s) in
                            currentS += 1
                            if currentS >= expectedS{
                                shows.append(show)
                                if shows.count >= expected{
                                    onSuccess(shows)
                                }
                            }
                        })
                    }                    
                })
            }
        case .Watched:
            let key = watchedShow
            let dictionary = ud.dictionary(forKey: key) ?? [:]
            let tmdb = TmdbWorker()
            
            let expected = dictionary.keys.count
            var shows = [TVShow]()
            var checked = 0
            if expected == 0{
                onSuccess([])
            }
            
            for (k, v) in dictionary{
                let epCount = ((v as? [String]) ?? []).count
                tmdb.getTVShow(by: Int(k)!, completion: { (show) in
                    if show.numberOfEpisodes <= epCount{
                        shows.append(show)
                    }
                    checked += 1
                    if checked >= expected{
                        onSuccess(shows)
                    }
                })
            }
        }
    }
    
    func list(do action: Action, show: TVShow, in listName: ListName, onSuccess: (ListName, Status, Action) -> Void) {
        let ud = UserDefaults.standard
        let id = String(show.id)
        
        var key: String
        switch listName {
        case .Watchlist:
            key = watchlistShow
            var dictionary = ud.dictionary(forKey: key) ?? [:]
            var status = dictionary.keys.contains(id)
            
            switch action {
            case .RequestStatus:
                break
            case .Add:
                if !status{
                    dictionary[id] = []
                }
            case .Remove:
                if status{
                    dictionary.removeValue(forKey: id)
                }
            case .Change:
                if status {
                    dictionary.removeValue(forKey: id)
                    
                }
                else {
                    dictionary[id] = []
                }
            }
            
            status = dictionary.keys.contains(id)
            
            ud.set(dictionary, forKey: key)
            
            if status {
                onSuccess(listName, .In, action)
            }
            else {
                onSuccess(listName, .Out, action)
            }
            
        case .Watched:
            key = watchedShow
            
            var dictionary = ud.dictionary(forKey: key) ?? [:]
            var array = (dictionary[id] as? [String]) ?? []
            var status = array.count >= show.numberOfEpisodes
            
            switch action {
            case .RequestStatus:
                break
            case .Add:
                if !status{
                    array.removeAll()
                    for season in show.seasons{
                        for episode in season.episodes{
                            array.append("\(season.seasonNumber)_\(episode.episodeNumber)")
                        }
                    }
                }
            case .Remove:
                if status{
                    array.removeAll()
                }
            case .Change:
                if status {
                    array.removeAll()
                }
                else {
                    array.removeAll()
                    for season in show.seasons{
                        for episode in season.episodes{
                            array.append("\(season.seasonNumber)_\(episode.episodeNumber)")
                        }
                    }
                }
            }
            
            status = array.count >= show.numberOfEpisodes
            dictionary[id] = array
            
            ud.set(dictionary, forKey: key)
            
            if status {
                onSuccess(listName, .In, action)
            }
            else {
                onSuccess(listName, .Out, action)
            }
        }
    }
    
    func list(do action: Action, episode: Episode, in listName: ListName, onSuccess: (ListName, Status, Action) -> Void) {
        let ud = UserDefaults.standard
        let id = String(episode.tvid)
        let season = String(episode.seasonNumber)
        let episode = String(episode.episodeNumber)
        let value = "\(season)_\(episode)"
        
        var key: String
        switch listName {
        case .Watchlist:
            key = watchlistShow
        case .Watched:
            key = watchedShow
        }
        var dictionary = ud.dictionary(forKey: key) ?? [:]
        var array = (dictionary[id] as? [String]) ?? []
        var status = array.contains(value)
        
        switch action {
        case .RequestStatus:
            break
        case .Add:
            if !status{
                array.append(value)
            }
        case .Remove:
            if status{
                if let index = array.index(of: value){
                    array.remove(at: index)
                }
            }
        case .Change:
            if status {
                if let index = array.index(of: value){
                    array.remove(at: index)
                }
            }
            else {
                array.append(value)
            }
        }
        
        status = array.contains(value)
        dictionary[id] = array
        ud.set(dictionary, forKey: key)
        
        if status {
            onSuccess(listName, .In, action)
        }
        else {
            onSuccess(listName, .Out, action)
        }
    }
    
    func list(do action: Action, movie: Movie, in listName: ListName, onSuccess: (ListName, Status, Action) -> Void){
        let ud = UserDefaults.standard
        
        var key: String
        switch listName {
        case .Watchlist:
            key = watchlistMovie
        case .Watched:
            key = watchedMovie
        }
        
        var list = ud.stringArray(forKey: key) ?? []
        var status = list.contains(String(movie.id))
        
        switch action {
        case .RequestStatus:
            break
        case .Add:
            if !status{
                list.append(String(movie.id))
            }
        case .Remove:
            if status{
                if let index = list.index(of: String(movie.id)){
                    list.remove(at: index)
                }
            }
        case .Change:
            if status {
                if let index = list.index(of: String(movie.id)){
                    list.remove(at: index)
                }
            }
            else {
                list.append(String(movie.id))
            }
        }
        
        status = list.contains(String(movie.id))
        
        ud.set(list, forKey: key)
        
        if status {
            onSuccess(listName, .In, action)
        }
        else {
            onSuccess(listName, .Out, action)
        }
    }
}
