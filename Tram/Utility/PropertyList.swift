//
//  Properties.swift
//  plist-kingfisher-alamofire
//
//  Created by Roman Abuzyarov on 14.05.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights reserved.
//

import Foundation

class PropertyList {
    private var dictionary : NSDictionary
    
    
    /// i.e. to use file "list.plist" use the following syntax:
    /// ```
    /// PropertyList(forResourse: "list", ofType: "plist")
    /// ```
    init?(forResource resource: String, ofType type: String){
        guard let path = Bundle.main.path(forResource: "keys", ofType: "plist") else { return nil }
        guard let keys = NSDictionary(contentsOfFile: path) else { return nil }
        
        dictionary = keys
    }
    
    /// Returns entry from plist with specific path.
    /// For example, to retreive element with key 'apiKey' from dictionary 'Dict' use the following syntax:
    /// ```
    /// propertyList["Dict", "apiKey"]
    /// ```
    /// - Parameter path: keys of dictionaries and key of entry in hierarchic order.
    subscript(path: String...) -> Any? {
        get{
            guard !path.isEmpty else { return nil }
            
            var iter = dictionary
            
            for key in path[0 ..< (path.count - 1)] {
                guard let tempDictionary = iter[key] as? NSDictionary else { return nil }
                iter = tempDictionary
            }
            
            guard let key = path.last else { return nil }            
            return iter[key]
        }
    }
}
