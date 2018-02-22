//
//  JSONMovie.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
class JSONMovie : Codable{
    var adult : Bool?
    var backdrop_path : String?
    var belongs_to_collection : JSONCollection?
    var budget : Int?
    var genres : [JSONGenre]?
    var homepage : String?
    var id : Int?
    var imdb_id : String?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var production_companies : [JSONCompany]?
    var production_countries : [JSONCountry]?
    var release_date : String?
    var revenue : Int?
    var runtime : Int?
    var spoken_languages : [JSONLanguage]?
    var status : String?
    var tagline : String?
    var title : String?
    var video : Bool?
    var vote_average : Double?
    var vote_count : Int?
}

class JSONCompany : Codable{
    var id = 0
    var name : String?
}

class JSONLanguage : Codable{
    var iso_639_1 : String?
    var name : String?
}

class JSONCollection : Codable{
    var id = 0
    var name : String?
    var backdrop_path : String?
    var poster_path : String?
}

class JSONGenre : Codable{
    var id = 0
    var name : String?
}

class JSONCountry : Codable{
    var iso_3166_1 : String?
    var name : String?
}

