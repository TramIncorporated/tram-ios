//
//  CrewMember.swift
//  Tram
//
//  Created by Roman Abuzyarov on 10.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Person {
    struct PersonJSONKeys{
        static let adult = JSONKeys.adult
        static let alsoKnownAs = JSONKeys.alsoKnownAs
        static let biography = JSONKeys.biography
        static let birthday = JSONKeys.birthday
        static let deathday = JSONKeys.deathday
        static let gender = JSONKeys.gender
        static let homepage = JSONKeys.homepage
        static let id = JSONKeys.id
        static let imdbId = JSONKeys.imdbId
        static let name = JSONKeys.name
        static let placeOfBirth = JSONKeys.placeOfBirth
        static let popularity = JSONKeys.popularity
        static let profilePath = JSONKeys.profilePath
    }
    
    init(json: JSON){
        adult = json[PersonJSONKeys.adult].boolValue
        alsoKnownAs = json[PersonJSONKeys.alsoKnownAs].arrayValue.map { $0.stringValue }
        biography = json[PersonJSONKeys.biography].stringValue
        birthday = json[PersonJSONKeys.birthday].string
        deathday = json[PersonJSONKeys.deathday].string
        gender = Gender(json[PersonJSONKeys.gender].intValue)
        homepage = json[PersonJSONKeys.homepage].string
        id = json[PersonJSONKeys.id].intValue
        imdbId = json[PersonJSONKeys.imdbId].stringValue
        name = json[PersonJSONKeys.name].stringValue
        placeOfBirth = json[PersonJSONKeys.placeOfBirth].string
        popularity = json[PersonJSONKeys.popularity].doubleValue
        profilePath = json[PersonJSONKeys.profilePath].string
    }
    
    var adult : Bool
    var alsoKnownAs : [String]
    var biography : String?
    var birthday : String?
    var deathday : String?
    
    // 0 - not, 1 - Female, 2 - Male
    var gender : Gender
    var homepage : String?
    var id : Int
    var imdbId : String
    var name : String
    var placeOfBirth : String?
    var popularity : Double
    var profilePath : String?
    
    var imageUrl : String {
        get{
            if let profilePath = profilePath{
                return "http://image.tmdb.org/t/p/w185\(profilePath)"
            }
            return ""
        }
    }
}
