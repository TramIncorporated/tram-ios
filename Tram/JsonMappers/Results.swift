//
//  TVShowSearchResult.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class TVShowSearchResult : Codable{
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [JSONShortTVShow] = []
}

class MovieSearchResult : Codable{
    var page = 0
    var total_results = 0
    var total_pages = 0
    var results : [JSONShortMovie] = []
}

class CreditsRequestResult : Codable{
    var id = 0
    var cast : [Cast] = []
    var crew : [Crew] = []
}
