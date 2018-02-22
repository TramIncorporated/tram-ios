//
//  Genre.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import Parse

class Genre : Codable{
    var id = 0
    var name = ""
    init(from json: JSONGenre){
        id = json.id
        name = json.name ?? ""
    }
}
