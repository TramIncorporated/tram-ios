//
//  CrewMember.swift
//  Tram
//
//  Created by Roman Abuzyarov on 10.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit

class Person : Hashable{
    var hashValue: Int = 0
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name==rhs.name && lhs.surname == rhs.surname
    }
    
    var name : String? = nil
    var surname : String? = nil
    var imageUrl : String? = nil
    
    var fullName: String {
        get{
            var res = ""
            if let name = name{
                res += name + " "
            }
            if let surname = surname{
                res += surname
            }
            return res
        }
    }
}
