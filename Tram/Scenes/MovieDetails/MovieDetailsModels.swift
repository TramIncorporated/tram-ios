//
//  MovieDetailsModels.swift
//  tram-clean
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright (c) 2018 Roman Abuzyarov. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MovieDetails
{
    // MARK: Use cases
    
    enum FillData
    {
        struct Request
        {
        }
        struct Response
        {
            var movie : Movie?
        }
        struct ViewModel
        {
            struct Job{
                var name: String?
                var role: String?
                var imageUrl: String?
            }
            var title: String?
            var year: String?
            var length: String?
            var genres: String?
            var heartRating: String?
            var starRating: String?
            var imageUrl: String?
            
            var plot: String?
            
            var cast: [Job]
            var crew: [Job]
            
            var details: [(key: String?, value: String?)]
        }
    }
}
