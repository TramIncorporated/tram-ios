//
//  TmdbWorker.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class TmdbWorker{
    let base = "https://api.themoviedb.org/3"
    let api_key = "a4eedc72a9524b6f354d4ce2624b29f7"
    
    func getMovie(by id: Int, onSuccess: @escaping (Movie)->Void) {
        let urlString = "\(base)/movie/\(id)?api_key=\(api_key)&append_to_response=credits"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do{
                    let jsonmovie = try JSONDecoder().decode(JSONMovie.self, from: data)
                    onSuccess(Movie(with: jsonmovie))
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
    private func searchMovies(query: String, onSuccess: @escaping (MovieSearchResult)->Void){
        let urlString = "\(base)/search/movie?api_key=\(api_key)&query=\(query.addingPercentEncoding(withAllowedCharacters: []) ?? "")"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do{
                    let movieSearchResult = try JSONDecoder().decode(MovieSearchResult.self, from: data)
                    onSuccess(movieSearchResult)
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
    func searchMovies(query: String, onSuccess: @escaping ([Movie])->Void){
        searchMovies(query: query) { (msr : MovieSearchResult) in
            var movies : [Movie] = []
            for mse in msr.results{
                self.getMovie(by: mse.id, onSuccess: { (movie) in
                    movies.append(movie)
                    if movies.count == msr.results.count{
                        onSuccess(movies)
                    }
                })
            }
        }
    }
    
    private func getCredits(movieId: Int, onSuccess: @escaping (CreditsRequestResult)->Void){
        let urlString = "\(base)/movie/\(movieId)/credits?api_key=\(api_key)"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do{
                    let credits = try JSONDecoder().decode(CreditsRequestResult.self, from: data)
                    onSuccess(credits)
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
    func getCredits(movieId: Int, onSuccess: @escaping ([Cast], [Crew])->Void){
        getCredits(movieId: movieId) { (crr : CreditsRequestResult) in
            onSuccess(crr.cast, crr.crew)
        }
    }
    
    func getTVShow(by id: Int, onSuccess: @escaping (TVShow)->Void){
        let urlString = "\(base)/tv/\(id)?api_key=\(api_key)&append_to_response=credits"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do{
                    let json = try JSONDecoder().decode(JSONTVShow.self, from: data)
                    onSuccess(TVShow(with: json))
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
    
    
    private func searchTVShows(query: String, onSuccess: @escaping (TVShowSearchResult)->Void){
        let urlString = "\(base)/search/tv?api_key=\(api_key)&query=\(query.addingPercentEncoding(withAllowedCharacters: []) ?? "")"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do{
                    let json = try JSONDecoder().decode(TVShowSearchResult.self, from: data)
                    onSuccess(json)
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
    func searchTVShows(query: String, onSuccess: @escaping ([TVShow])->Void){
        searchTVShows(query: query) { (json : TVShowSearchResult) in
            var shows : [TVShow] = []
            for jsonshow in json.results{
                self.getTVShow(by: jsonshow.id, onSuccess: { (show) in
                    shows.append(show)
                    if shows.count == json.results.count{
                        onSuccess(shows)
                    }
                })
            }
        }
    }
    
    func getSeason(tvid: Int, seasonNumber: Int, onSuccess: @escaping (Season)->Void){
        let urlString = "\(base)/tv/\(tvid)/season/\(seasonNumber)?api_key=\(api_key)"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do{
                    let json = try JSONDecoder().decode(JSONSeason.self, from: data)
                    onSuccess(Season(full: json))
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
}
