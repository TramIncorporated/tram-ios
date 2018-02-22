//
//  Collection.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class Collection : Codable{
    var id = 0
    var name = ""
    var backdropPath = ""
    var posterPath = ""
    init(from json: JSONCollection){
        id = json.id
        name = json.name ?? ""
        backdropPath = json.backdrop_path ?? ""
        posterPath = json.poster_path ?? ""
    }
}
