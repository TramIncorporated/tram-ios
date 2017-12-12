//
//  Movies
//  Tram
//
//  Created by Roman Abuzyarov on 19.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import Foundation
import UIKit

class Movies{
    private init(){
        let harrisonFord = CrewMember()
        harrisonFord.Name = "Harrison"
        harrisonFord.Surname = "Ford"
        harrisonFord.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade.jpg")
        
        let wesleySnipes = CrewMember()
        wesleySnipes.Name = "Wesley"
        wesleySnipes.Surname = "Snipes"
        wesleySnipes.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade.jpg")
        
        let stephenDorff = CrewMember()
        stephenDorff.Name = "Stephen"
        stephenDorff.Surname = "Dorff"
        stephenDorff.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade.jpg")
        
        let rutgerHauer = CrewMember()
        rutgerHauer.Name = "Rutger"
        rutgerHauer.Surname = "Hauer"
        rutgerHauer.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade.jpg")
        
        let ryanGosling = CrewMember()
        ryanGosling.Name = "Ryan"
        ryanGosling.Surname = "Gosling"
        ryanGosling.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade.jpg")
        
        var m = Movie()
        m.Title = "Blade"
        m.Year = 1998
        m.Length = "1h 23min"
        m.Genres = ["dicke", "bals"]
        m.HeartRating = "71%"
        m.StarRating = "70%"
        m.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade.jpg")
        m.Cast.append((person: stephenDorff, role: "role1"))
        m.Cast.append((wesleySnipes, "role2"))
        movies.append(m)
        
        m = Movie()
        m.Title = "Blade Runner 2049"
        m.Year = 2017
        m.Length = "2h 44min"
        m.Genres = ["Mystery", "Sci-Fi", "Thriller"]
        m.HeartRating = "84%"
        m.StarRating = "50%"
        m.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade_runner_2049.jpg")
        m.Cast.append((harrisonFord,"Rick Deckard"))
        m.Cast.append((ryanGosling, "K"))
        movies.append(m)
        
        m = Movie()
        m.Title = "Blade Runner"
        m.Year = 1982
        m.Length = "4h 56min"
        m.Genres = ["1", "2"]
        m.HeartRating = "82%"
        m.StarRating = "70%"
        m.Image = UIImage(named: "/Users/romanabuzyarov/Projects/Tram/posters/blade_runner.jpg")
        m.Cast.append((harrisonFord, "Rick Deckard"))
        m.Cast.append((rutgerHauer, "role1"))
        movies.append(m)
    }
    var movies : [Movie] = []
    static let Instance = Movies()
}
