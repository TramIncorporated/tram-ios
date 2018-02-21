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
    var name: String { get set }
    var position: String { get set }
    var profilePath: String { get set }
    var gender : Int { get set }
    var id : Int { get set }
    var creditId : String { get set }
    var imageUrl: String { get }
}

struct Cast : Job{
    var imageUrl: String {
        get{
            return "http://image.tmdb.org/t/p/w185\(profilePath)"
        }
    }
    
    var name: String = ""
    var position: String = ""// character
    var profilePath: String = "" // profile_path
    var castId = -1 // cast_id
    var creditId = "" // credit_id
    var gender = -1
    var id = -1 // ID
    var order = -1
    
    init(pfo: PFObject){
        self.name = pfo.getString(forKey: "name")
        self.position = pfo.getString(forKey: "character")
        self.profilePath = pfo.getString(forKey: "profile_path")
        self.castId = pfo.getInt(forKey: "cast_id")
        self.creditId = pfo.getString(forKey: "credit_id")
        self.gender = pfo.getInt(forKey: "gender")
        self.id = pfo.getInt(forKey: "ID")
        self.order = pfo.getInt(forKey: "order")
    }
}

struct Crew : Job{
    var imageUrl: String {
        get{
            return "http://image.tmdb.org/t/p/w185\(profilePath)"
        }
    }
    
    var name: String = ""
    var position: String = "" // job
    var profilePath: String = "" // profile_path
    var creditId = "" // credit_id
    var department = ""
    var gender = -1
    var id = -1 // ID
    
    init(pfo: PFObject){
        self.name = pfo.getString(forKey: "name")
        self.position = pfo.getString(forKey: "character")
        self.profilePath = pfo.getString(forKey: "profile_path")
        self.creditId = pfo.getString(forKey: "creditId")
        self.gender = pfo.getInt(forKey: "gender")
        self.id = pfo.getInt(forKey: "ID")
        self.department = pfo.getString(forKey: "department")
    }
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
