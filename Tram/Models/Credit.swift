//
//  Job.swift
//  Tram
//
//  Created by Roman Abuzyarov on 17.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Credit{
    var name : String {get set}
    var position : String {get set}
    var profilePath : String? {get set}
    var gender : Gender {get set}
    var id : Int { get set }
    var creditId : String { get set }
    var imageUrl : URL? { get }
}

struct Cast : Credit {
    struct CastJSONKeys {
        static let castId = JSONKeys.castId
        static let character = JSONKeys.character
        static let creditId = JSONKeys.creditId
        static let gender = JSONKeys.gender
        static let id = JSONKeys.id
        static let name = JSONKeys.name
        static let order = JSONKeys.order
        static let profilePath = JSONKeys.profilePath
    }
    
    init(json: JSON){
        castId = json[CastJSONKeys.castId].intValue
        position = json[CastJSONKeys.character].stringValue
        creditId = json[CastJSONKeys.creditId].stringValue
        gender = Gender(json[CastJSONKeys.gender].int)
        id = json[CastJSONKeys.id].intValue
        name = json[CastJSONKeys.name].stringValue
        order = json[CastJSONKeys.order].intValue
        profilePath = json[CastJSONKeys.profilePath].string
    }
    
    var imageUrl: URL? {
        if let profilePath = profilePath{
            return URL(string: "http://image.tmdb.org/t/p/w185\(profilePath)")
        }
        return nil
    }
    
    var position: String
    var name: String
    var profilePath: String?
    var castId: Int
    var creditId : String
    var gender: Gender
    var id : Int
    var order : Int
}

struct Crew : Credit{
    struct CrewJSONKeys {
        static let creditId = JSONKeys.creditId
        static let department = JSONKeys.department
        static let gender = JSONKeys.gender
        static let id = JSONKeys.id
        static let job = JSONKeys.job
        static let name = JSONKeys.name
        static let profilePath = JSONKeys.profilePath
    }
    
    init(json: JSON){
        creditId = json[CrewJSONKeys.creditId].stringValue
        department = json[CrewJSONKeys.department].stringValue
        gender = Gender(json[CrewJSONKeys.gender].int)
        id = json[CrewJSONKeys.id].intValue
        position = json[CrewJSONKeys.job].stringValue
        name = json[CrewJSONKeys.name].stringValue
        profilePath = json[CrewJSONKeys.profilePath].string
    }
    
    
    var imageUrl: URL? {
        get{
            if let profilePath = profilePath{
                return URL(string: "http://image.tmdb.org/t/p/w185\(profilePath)")
            }
            return nil
        }
    }
    
    var name: String
    var position: String
    var profilePath: String? // profile_path
    var creditId : String
    var department : String
    var gender: Gender
    var id : Int
}
