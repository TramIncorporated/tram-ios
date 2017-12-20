//
//  Profile.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import Parse

class Profile{
    private init(){}
    static let Instance = Profile()
    
    var watchlist : [Movie]{
        get{
            return movies(from: "watchlist")
        }
    }
    
    var watched : [Movie]{
        get{
            return movies(from: "watched")
        }
    }
    
    private func movies(from list:String) -> [Movie]{
        return Movies.Instance.movies.filter { (m) -> Bool in
            if let list = (UserDefaults.standard.stringArray(forKey: list)){
                return list.contains(m.objectId)
            }
            return false
        }
    }
    
    func add(movie: Movie, to list: String){
        if var array = UserDefaults.standard.stringArray(forKey: list){
            array.append(movie.objectId)
            UserDefaults.standard.set(array, forKey: list)
        }
        else{
            let array = [movie.objectId]
            UserDefaults.standard.set(array, forKey: list)
        }
    }
    
    func remove(movie: Movie, from list: String){
        if var array = UserDefaults.standard.stringArray(forKey: list){
            if let index = array.index(of: movie.objectId){
                array.remove(at: index)
                UserDefaults.standard.set(array, forKey: list)
            }
        }
    }
    
    func contains(movie: Movie, in list: String) -> Bool{
        if let array = UserDefaults.standard.stringArray(forKey: list){
            return array.contains(movie.objectId)
        }
        return false
    }
}
