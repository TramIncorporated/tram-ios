//
//  HideableDataSource.swift
//  Tram
//
//  Created by Roman Abuzyarov on 19.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import Foundation

class HideableDataSource<T : Any> {
    init(items: [T], hidden: Bool){
        self.items = items
        self.hidden = hidden
    }
    
    var items : [T]
    var hidden : Bool
    
    func toggle(){
        hidden = !hidden
    }
    
    func indexPaths(for section: Int) -> [IndexPath]{
        var res = [IndexPath]()
        for i in 0..<items.count{
            res.append(IndexPath(row: i, section: section))
        }
        return res
    }
    
    func setItems(items: [T]){
        self.items = items
    }
    
    var dataSource : [T]{
        get{
            if hidden{
                return []
            }
            return items
        }
    }
}
