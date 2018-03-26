//
//  WatchlistSceneWorker.swift
//  Tram
//
//  Created by Roman Abuzyarov on 22.03.2018.
//  Copyright (c) 2018 Tram, inc.. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class WatchlistSceneWorker
{
    func getUser(id: Int, onSuccess: @escaping (User)->Void)
    {
        LocalWorker().getUser(by: id, onSuccess: onSuccess)
    }
}
