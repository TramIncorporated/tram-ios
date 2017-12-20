//
//  BarsCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 14.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    var data = [(amount: 15, of: 26, type: "movies"),
                (amount: 30, of: 64, type: "TV series"),
                (amount: 1, of: 3, type: "games")]
    
    let progressColors = [UIColor(red: 250.0/255.0, green: 0, blue: 101.0/255.0, alpha: 1),
                          UIColor(red: 15.0/255.0, green: 119.0/255.0, blue: 251.0/255.0, alpha: 1),
                          UIColor(red: 30.0/255.0, green: 227.0/255.0, blue: 71.0/255.0, alpha: 1),
                          UIColor()]
    
    let trackColors = [UIColor(red: 247.0/255.0, green: 154.0/255.0, blue: 200.0/255.0, alpha: 1),
                          UIColor(red: 143.0/255.0, green: 208.0/255.0, blue: 254.0/255.0, alpha: 1),
                          UIColor(red: 151.0/255.0, green: 245.0/255.0, blue: 182.0/255.0, alpha: 1)]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barCell", for: indexPath) as! BarCollectionViewCell
        
        //let piece = data[indexPath.row]
        
        cell.progressBar.progress = Float(Profile.Instance.watched.count) / Float(Profile.Instance.watched.count+Profile.Instance.watchlist.count)
        cell.progressLabel.text = "\(Profile.Instance.watched.count) out of \(Profile.Instance.watched.count+Profile.Instance.watchlist.count)"
        cell.typeLabel.text = "movies"
        
        cell.progressBar.progressTintColor = progressColors[indexPath.row % progressColors.count]
        cell.progressBar.trackTintColor = trackColors[indexPath.row % trackColors.count]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height : CGFloat = 70
        return CGSize(width: width, height: height)
    }
    
}
