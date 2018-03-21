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
    var credits: JSONCredits?
}

class JSONShortMovie : Codable{
    var vote_count = 0
    var id = 0
    var video = false
    var vote_average = 0.0
    var title : String?
    var popularity = 0.0
    var poster_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : [Int] = []
    var backdrop_path : String?
    var adult = false
    var overview : String?
    var release_date : String?
}

class JSONCredits : Codable{
    var cast: [Cast]?
    var crew: [Crew]?
}

class JSONCompany : Codable{
    var id = 0
    var name : String?
    var logo_path : String?
    var origin_country : String?
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

class JSONTVShow : Codable {
    var backdrop_path : String?
    var created_by : [JSONCreator]?
    var episode_run_time : [Int]?
    var first_air_date : String?
    var genres : [JSONGenre]?
    var homepage : String?
    var id : Int?
    var in_production : Bool?
    var languages : [String]?
    var last_air_date : String?
    var name : String?
    var networks : [JSONNetwork]?
    var number_of_episodes : Int?
    var number_of_seasons : Int?
    var origin_country : [String]?
    var original_language : String?
    var original_name : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var production_companies : [JSONCompany]?
    var seasons : [JSONShortSeason]?
    var status : String?
    var type : String?
    var vote_average : Double?
    var vote_count : Int?
    var credits : JSONCredits?
}

class JSONSeason : Codable{
    var _id : String?
    var air_date : String?
    var episodes : [JSONEpisode]?
    var id : Int?
    var name : String?
    var overview : String?
    var poster_path : String?
    var season_number : Int?
}

class JSONEpisode : Codable{
    var air_date : String?
    var crew : [Crew]?
    var episode_number : Int?
    var guest_stars : [Cast]?
    var name : String?
    var overview : String?
    var id : Int?
    var production_code : String?
    var season_number : Int?
    var still_path : String?
    var vote_average : Double?
    var vote_count : Int?
}

class JSONShortSeason : Codable{
    var air_date : String?
    var episode_count : Int?
    var id : Int?
    var name : String?
    var overview : String?
    var poster_path : String?
    var season_number : Int?
}

class JSONNetwork : Codable{
    var name : String?
    var id : Int?
    var logo_path : String?
    var origin_country : String?
}

class JSONCreator : Codable{
    var id : Int?
    var name : String?
    var gender : Int?
    var profile_path : String?
}

class JSONShortTVShow : Codable{
    var original_name : String?
    var id : Int = 0
    var name : String?
    var vote_count : Int?
    var vote_average : Double?
    var poster_path : String?
    var first_air_date : String?
    var popularity : Double?
    var genre_ids : [Int]?
    var original_language : String?
    var backdrop_path : String?
    var overview : String?
    var origin_country : [String]?
}
