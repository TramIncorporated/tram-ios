//
//  Genre.swift
//  Tram
//
//  Created by Roman Abuzyarov on 15.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import Parse

class Genre{
    var objectId = ""
    var id = 0
    var name = ""
    
    init(pfo : PFObject){
        self.objectId = pfo.objectId!
        self.id = pfo["id"] as! Int
        self.name = pfo["name"] as! String
    }
}
