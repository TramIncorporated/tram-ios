//
//  MovieDetailsInteractor.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright (c) 2018 Roman Abuzyarov. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsBusinessLogic
{
    func fillData(request: MovieDetails.FillData.Request)
    func loadPeople(request: MovieDetails.LoadPeople.Request)
    func watchlist(request: MovieDetails.Watchlist.Request)
}

protocol MovieDetailsDataStore
{
    var movie: Movie? { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore
{
    var movie: Movie?
    
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorker?
    
    init(){
        worker = MovieDetailsWorker()
    }
    
    func fillData(request: MovieDetails.FillData.Request)
    {
        let response = MovieDetails.FillData.Response(movie: movie)
        presenter?.fillData(response: response)
    }
    
    func loadPeople(request: MovieDetails.LoadPeople.Request) {
        if let movie = movie{
            TmdbWorker().getCredits(movieId: movie.id, onSuccess: { (cast, crew) in
                DispatchQueue.main.async {
                    let response = MovieDetails.LoadPeople.Response(type: .Cast, people: cast)
                    self.presenter?.presentPeople(response: response)
                    let response1 = MovieDetails.LoadPeople.Response(type: .Crew, people: crew)
                    self.presenter?.presentPeople(response: response1)
                }
            })
        }
    }
    
    func watchlist(request: MovieDetails.Watchlist.Request){
        if let movie = movie{
            worker?.watchlist(movie: movie, action: request.action, onSuccess: { (status) in
                self.presenter?.presentWatchlist(response: MovieDetails.Watchlist.Response(status: status))
            })
        }
    }
}
