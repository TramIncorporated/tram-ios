//
//  UserWorkerProtocol.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

enum ListName{
    case Watchlist
    case Watched
}
enum Status{
    case In
    case Out
}
enum Action{
    case Add
    case Remove
    case RequestStatus
    case Change
}

protocol UserWorker{
    
    func list(do action: Action, movie: Movie, in listName: ListName, onSuccess: (ListName, Status, Action)->Void)
    func list(do action: Action, show: TVShow, in listName: ListName, onSuccess: (ListName, Status, Action)->Void)
    func list(do action: Action, episode: Episode, in listName: ListName, onSuccess: (ListName, Status, Action)->Void)
    
    
}
