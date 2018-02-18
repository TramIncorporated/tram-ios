//
//  CrewMember.swift
//  Tram
//
//  Created by Roman Abuzyarov on 10.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Person : Hashable{
    var hashValue: Int = 0
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name==rhs.name
    }
    
    var objectId = ""
    var biography = ""
    var birthday = ""
    var deathday = ""
    var name = ""
    var gender = 0
    var id = 0
    var homepage = ""
    var imdbId = "" //_
    var placeOfBirth = "" //_
    var popularity = 0
    var profilePath = "" //_
    
    var imageUrl : String {
        get{
            return "http://image.tmdb.org/t/p/w185\(profilePath)"
        }
    }
    
    init(pfo: PFObject){
        if let objectId = pfo["objectId"] as? String{
            self.objectId = objectId
        }
        if let biography = pfo["biography"] as? String{
            self.biography = biography
        }
        if let birthday = pfo["birthday"] as? String{
            self.birthday = birthday
        }
        if let deathday = pfo["deathday"] as? String{
            self.deathday = deathday
        }
        if let name = pfo["name"] as? String{
            self.name = name
        }
        if let gender = pfo["gender"] as? Int{
            self.gender = gender
        }
        if let id = pfo["ID"] as? Int{
            self.id = id
        }
        if let homepage = pfo["homepage"] as? String{
            self.homepage = homepage
        }
        if let imdbId = pfo["imdb_id"] as? String{
            self.imdbId = imdbId
        }
        if let placeOfBirth = pfo["place_of_birth"] as? String{
            self.placeOfBirth = placeOfBirth
        }
        if let popularity = pfo["popularity"] as? Int{
            self.popularity = popularity
        }
        if let profilePath = pfo["profile_path"] as? String{
            self.profilePath = profilePath
        }
    }
}
