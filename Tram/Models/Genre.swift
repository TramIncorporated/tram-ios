//
//  Genre.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Genre {
    struct GenreJSONKeys {
        static let id = JSONKeys.id
        static let name = JSONKeys.name
    }
    
    var id : Int
    var name : String
    init(json: JSON){
        id = json[GenreJSONKeys.id].intValue
        name = json[GenreJSONKeys.name].stringValue
    }
}
