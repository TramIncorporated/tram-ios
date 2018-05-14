//
//  Company.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Company {
    struct CompanyJSONKeys{
        static let name = JSONKeys.name
        static let id = JSONKeys.id
        static let logoPath = JSONKeys.logoPath
        static let originCountry = JSONKeys.originCountry
    }
    
    var id : Int
    var name : String
    var logoPath : String?
    var originCountry : String
    init(json: JSON){
        id = json[CompanyJSONKeys.id].intValue
        name = json[CompanyJSONKeys.name].stringValue
        logoPath = json[CompanyJSONKeys.logoPath].string
        originCountry = json[CompanyJSONKeys.originCountry].stringValue
    }
}
