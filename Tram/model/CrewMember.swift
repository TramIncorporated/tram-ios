//
//  CrewMember.swift
//  Tram
//
//  Created by Roman Abuzyarov on 10.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation

class CrewMember : Hashable{
    var hashValue: Int = 0
    
    static func ==(lhs: CrewMember, rhs: CrewMember) -> Bool {
        return lhs.Name==rhs.Name && lhs.Surname == rhs.Surname
    }
    
    var Name : String? = nil
    var Surname : String? = nil
    
    func toString() -> String{
        if let name = Name{
            if let sur = Surname{
                return "\(name) \(sur)"
            }
        }
        return ""
    }
}
