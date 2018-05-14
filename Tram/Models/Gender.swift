//
//  Gender.swift
//  Tram
//
//  Created by Roman Abuzyarov on 14.05.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

enum Gender : Int {
    case notStated = 0
    case Female = 1
    case Male = 2
    
    init(_ gender: Int?){
        if let gender = gender {
            switch gender {
            case 1...2: self.init(rawValue: gender)!
            default: self.init(rawValue: 0)!
            }
        }
        self.init(rawValue: 0)!
    }
}
