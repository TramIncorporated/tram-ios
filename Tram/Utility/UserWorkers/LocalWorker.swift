//
//  LocalWorker.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class LocalWorker : UserWorker{
    
    func list(do action: Action, show: TVShow, in listName: ListName, onSuccess: (ListName, Status, Action) -> Void) {
        let ud = UserDefaults.standard
        let id = String(show.id)
        
        var key: String
        switch listName {
        case .Watchlist:
            key = "watchlist_show"
        case .Watched:
            key = "watched_show"
        }
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
    }
    
    func list(do action: Action, episode: Episode, in listName: ListName, onSuccess: (ListName, Status, Action) -> Void) {
        let ud = UserDefaults.standard
        let id = String(episode.tvid!)
        let season = String(episode.seasonNumber)
        let episode = String(episode.episodeNumber)
        let value = "\(season)_\(episode)"
        
        var key: String
        switch listName {
        case .Watchlist:
            key = "watchlist_show"
        case .Watched:
            key = "watched_show"
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
            key = "watchlist_movie"
        case .Watched:
            key = "watched_movie"
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
