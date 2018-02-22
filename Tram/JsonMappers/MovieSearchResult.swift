//
//  MovieSearchResult.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class MovieSearchResult : Codable{
    var page = 0
    var total_results = 0
    var total_pages = 0
    var results : [MovieSearchEntry] = []
}
