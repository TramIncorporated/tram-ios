//
//  Collection.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Collection : Codable{
    struct CollectionJSONKeys{
        static let id = JSONKeys.id
        static let name = JSONKeys.name
        static let backdropPath = JSONKeys.backdropPath
        static let posterPath = JSONKeys.posterPath
    }
    
    var id : Int
    var name : String
    var backdropPath : String?
    var posterPath : String?
    init(json: JSON){
        id = json[CollectionJSONKeys.id].intValue
        name = json[CollectionJSONKeys.name].stringValue
        backdropPath = json[CollectionJSONKeys.backdropPath].string
        posterPath = json[CollectionJSONKeys.posterPath].string
    }
}
