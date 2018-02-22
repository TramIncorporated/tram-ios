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

class Person : Codable{
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
}
