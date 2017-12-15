//
//  Country.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import Parse

class Country{
    var objectId = ""
    var iso = ""
    var name = ""
    
    init(pfo : PFObject){
        self.objectId = pfo.objectId!
        self.iso = pfo["iso_3166_1"] as! String
        self.name = pfo["name"] as! String
    }
}
