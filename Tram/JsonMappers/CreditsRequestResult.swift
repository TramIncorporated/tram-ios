//
//  CreditsRequestResult.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class CreditsRequestResult : Codable{
    var id = 0
    var cast : [Cast] = []
    var crew : [Crew] = []
}
