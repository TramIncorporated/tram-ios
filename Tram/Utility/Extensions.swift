//
//  Extensions.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import UIKit

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

extension UIButton {
    func rotate(hidden: Bool, animate: Bool){
        var rotation : CGFloat
        if hidden{
            rotation = CGFloat.pi
        }
        else{
            rotation = 0
        }
        if animate{
            UIView.animate(withDuration: 0.25) {
                self.transform = CGAffineTransform(rotationAngle: rotation)
            }
        }
        else{
            self.transform = CGAffineTransform(rotationAngle: rotation)
        }
    }
    func rotate(animate: Bool){
        if animate{
            UIView.animate(withDuration: 0.25) {
                self.transform = self.transform.rotated(by: CGFloat.pi)
            }
        }
        else{
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }
    }
}
