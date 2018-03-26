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
        let filtered = self.filter { $0.trimmingCharacters(in: [" ", "\n"]) != "" }
        if filtered.count == 0{
            return ""
        }
        if filtered.count == 1{
            return filtered[0]
        }
        return "• " + filtered.joined(separator: "\n• ")
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

extension UIColor{
    convenience init(hex: String){
        let hex = hex.trimmingCharacters(in: ["#", " "])
        switch hex.count {
        case 6:
            let scanner = Scanner(string: hex)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                let b = CGFloat(hexNumber & 0x0000ff) / 255
                let a = CGFloat(255) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        case 8:
            let scanner = Scanner(string: hex)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                let g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                let b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                let a = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        default:
            self.init()
            return
        }
        self.init()
    }
}

