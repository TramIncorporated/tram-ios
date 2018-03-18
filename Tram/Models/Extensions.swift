//
//  Extensions.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

extension Int{
    func toDollarString() -> String{
        let str = String(self)
        var value = ""
        var tricount = 0
        for digit in str.reversed() {
            if tricount == 3{
                value = ",\(value)"
                tricount = 0
            }
            value = "\(digit)\(value)"
            tricount+=1
        }
        
        return "$\(value)"
    }
}

extension Array where Element == String{
    func toBulletList() -> String{
        if self.count == 0{
            return ""
        }
        return "• " + self.joined(separator: "\n• ")
    }
}
