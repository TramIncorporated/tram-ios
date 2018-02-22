//
//  Company.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class Company : Codable{
    var id = 0
    var name = ""
    init(from json: JSONCompany){
        id = json.id
        name = json.name ?? ""
    }
}
