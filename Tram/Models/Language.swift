//
//  Language.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class Language : Codable{
    var code = ""
    var name = ""
    
    init(from json: JSONLanguage){
        code = json.iso_639_1 ?? ""
        name = json.name ?? ""
    }
}
