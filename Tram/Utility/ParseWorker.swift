//
//  ParseWorker.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import Parse

enum JobType{
    case Crew
    case Cast
}

class ParseWorker{
    func loadCast(of movie: Movie, onSuccess: @escaping ([Cast])->Void){
//        movie.getCast(onSuccess: onSuccess)
    }
    
    func loadCrew(of movie: Movie, onSuccess: @escaping ([Crew])->Void){
//        movie.getCrew(onSuccess: onSuccess)
    }
}
