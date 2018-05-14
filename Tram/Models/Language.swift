//
//  Language.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Language {
    struct LanguageJSONKeys{
        static let iso_639_1 = JSONKeys.iso_639_1
        static let name = JSONKeys.name
    }
    
    var iso_639_1 : String
    var name : String
    
    init(json: JSON){
        iso_639_1 = json[LanguageJSONKeys.iso_639_1].stringValue
        name = json[LanguageJSONKeys.name].stringValue
    }
}
