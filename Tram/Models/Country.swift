//
//  Country.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Country {
    struct CountryJSONKeys {
        static let iso_3166_1 = JSONKeys.iso_3166_1
        static let name = JSONKeys.name
    }
    
    var iso_3166_1 : String
    var name : String
    init(json: JSON){
        iso_3166_1 = json[CountryJSONKeys.iso_3166_1].stringValue
        name = json[CountryJSONKeys.name].stringValue
    }
}
