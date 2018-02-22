//
//  Job.swift
//  Tram
//
//  Created by Roman Abuzyarov on 17.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import Parse

protocol Job{
    var name : String? {get set}
    var position : String {get set}
    var profile_path : String? {get set}
    var gender : Int {get set}
    var id : Int {get set}
    var credit_id : String? {get set}
    var imageUrl : String {get}
}

struct Cast : Codable, Job{
    var position: String{
        get{
            return character ?? ""
        }
        set{
            character = newValue
        }
    }
    
    var imageUrl: String {
        if let profile_path = profile_path{
            return "http://image.tmdb.org/t/p/w185\(profile_path)"
        }
        return ""
    }
    
    var name: String?
    var character: String?// character
    var profile_path: String? // profile_path
    var cast_id = -1 // cast_id
    var credit_id : String? // credit_id
    var gender = -1
    var id = -1 // ID
    var order = -1
}

struct Crew : Codable, Job{
    
    var position: String {
        get{
            return job ?? ""
        }
        set{
            job = newValue
        }
    }
    
    var imageUrl: String {
        get{
            if let profile_path = profile_path{
            return "http://image.tmdb.org/t/p/w185\(profile_path)"
            }
            return ""
        }
    }
    
    var name: String?
    var job: String? // job
    var profile_path: String? // profile_path
    var credit_id : String? // credit_id
    var department : String?
    var gender = -1
    var id = -1 // ID
}

extension PFObject{
    func getString(forKey: String) -> String{
        if let value = self[forKey] as? String{
            return value
        }
        return ""
    }
    func getInt(forKey: String) -> Int {
        if let value = self[forKey] as? Int{
            return value
        }
        return -1
    }
}
