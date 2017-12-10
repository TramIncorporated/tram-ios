//
//  MediaEntry.swift
//  Tram
//
//  Created by Roman Abuzyarov on 07.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit

protocol MediaEntry{
    
}

class Movie : MediaEntry{
    init(){}
    
    var Title : String? = nil
    var Year : Int? = nil
    var Length : String? = nil
    var Genres : [String] = []
    var HeartRating : String? = nil
    var StarRating : String? = nil
    
    var Image : UIImage? = nil
    var Crew : [CrewMember : String] = [:]
    var Cast : [CrewMember : String] = [:]
}
