//
//  MovieSearchEntry.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class MovieSearchEntry : Codable{
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
