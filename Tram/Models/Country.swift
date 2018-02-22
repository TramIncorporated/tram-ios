//
//  Country.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import Parse

class Country : Codable{
    var code = ""
    var name = ""
    init(from json: JSONCountry){
        code = json.iso_3166_1 ?? ""
        name = json.name ?? ""
    }
}
