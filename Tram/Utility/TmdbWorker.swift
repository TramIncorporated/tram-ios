//
//  TmdbWorker.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TmdbWorker{
    let base = "https://api.themoviedb.org/3"
    let apiKey : String = PropertyList(forResource: "keys", ofType: "plist")?["TMDB", "apiKey"] as? String ?? ""
    
    func getMovie(by id: Int, completion: @escaping (Movie)->Void){
        let urlString = "\(base)/movie/\(id)"
        let parameters = ["api_key": apiKey,
                          "append_to_response": "credits"]
        
        Alamofire
            .request(urlString, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                if let error = response.error{
                    print("Error while performing request:\n\t\(urlString)")
                    print(error.localizedDescription)
                }
                    
                else if
                    let data = response.data,
                    let json = try? JSON(data: data){
                    let movie = Movie(json: json)
                    completion(movie)
                }
        }
    }
    
    private func searchMovies(query: String, page: Int, completion: @escaping (_ ids: [Int])->Void){
        let urlString = "\(base)/search/movie"
        let parameters = ["api_key": apiKey,
                          "query": query,
                          "page": "\(page)"]
        
        Alamofire
            .request(urlString, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                if let error = response.error{
                    print("Error while performing request:\n\t\(urlString)")
                    print(error.localizedDescription)
                }
                    
                else if
                    let data = response.data,
                    let json = try? JSON(data: data){
                    let ids = json[JSONKeys.results].arrayValue.map { $0[JSONKeys.id].intValue }
                    completion(ids)
                }
        }
    }
    
    func searchMovies(query: String, page: Int, completion: @escaping ([Movie])->Void){
        searchMovies(query: query, page: page) { (ids : [Int]) in
            var movies : [Movie] = []
            for id in ids{
                self.getMovie(by: id, completion: { (movie) in
                    movies.append(movie)
                    if movies.count == ids.count{
                        completion(movies)
                    }
                })
            }
        }
    }
    
    func getTVShow(by id: Int, completion: @escaping (TVShow)->Void){
        let urlString = "\(base)/tv/\(id)"
        let parameters = ["api_key": apiKey,
                          "append_to_response": "credits"]
        
        Alamofire
            .request(urlString, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                if let error = response.error{
                    print("Error while performing request:\n\t\(urlString)")
                    print(error.localizedDescription)
                }
                    
                else if
                    let data = response.data,
                    let json = try? JSON(data: data){
                    let tvshow = TVShow(json: json)
                    completion(tvshow)
                }
        }
    }
    
    private func searchTVShows(query: String, page: Int, completion: @escaping (_ ids: [Int])->Void){
        let urlString = "\(base)/search/tv"
        let parameters = ["api_key": apiKey,
                          "query": query,
                          "page": "\(page)"]
        Alamofire
            .request(urlString, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                if let error = response.error{
                    print("Error while performing request:\n\t\(urlString)")
                    print(error.localizedDescription)
                }
                    
                else if
                    let data = response.data,
                    let json = try? JSON(data: data){
                    let ids = json[JSONKeys.results].arrayValue.map { $0[JSONKeys.id].intValue }
                    completion(ids)
                }
        }
    }
    
    func searchTVShows(query: String, page: Int, completion: @escaping ([TVShow])->Void){
        searchTVShows(query: query, page: page) { (ids: [Int]) in
            var shows : [TVShow] = []
            for id in ids{
                self.getTVShow(by: id, completion: { (show) in
                    shows.append(show)
                    if shows.count == ids.count{
                        completion(shows)
                    }
                })
            }
        }
    }
    
    func getSeason(tvid: Int, seasonNumber: Int, completion: @escaping (Season)->Void){
        
        let urlString = "\(base)/tv/\(tvid)/season/\(seasonNumber)"
        let parameters = ["api_key": apiKey]
        
        Alamofire
            .request(urlString, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                if let error = response.error{
                    print("Error while performing request:\n\t\(urlString)")
                    print(error.localizedDescription)
                }
                    
                else if
                    let data = response.data,
                    let json = try? JSON(data: data){
                    let season = Season(json: json, tvid: tvid)
                    completion(season)
                }
        }
    }
}
