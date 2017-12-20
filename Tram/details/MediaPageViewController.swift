//
//  MediaPageViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class MediaPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var myMovie : Movie? = nil
    @IBOutlet weak var collection: UICollectionView!
    
    @IBAction func watchlistButtonPressed(_ sender: Any) {
        if let movie = myMovie{
            if let button = sender as? UIButton{
                if Profile.Instance.contains(movie: movie, in: "watchlist"){
                    Profile.Instance.remove(movie: movie, from: "watchlist")
                    button.setTitle("Add to watchlist", for: UIControlState.normal)
                }
                else{
                    Profile.Instance.add(movie: movie, to: "watchlist")
                    button.setTitle("Remove from watchlist", for: UIControlState.normal)
                }
            }
        }
        //collection.reloadItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    @IBAction func watchedButtonPressed(_ sender: Any) {
        if let movie = myMovie{
            if let button = sender as? UIButton{
                if Profile.Instance.contains(movie: movie, in: "watched"){
                    Profile.Instance.remove(movie: movie, from: "watched")
                    button.setTitle("Watch", for: UIControlState.normal)
                }
                else{
                    Profile.Instance.add(movie: movie, to: "watched")
                    button.setTitle("Unwatch", for: UIControlState.normal)
                    if Profile.Instance.contains(movie: movie, in: "watchlist"){
                        Profile.Instance.remove(movie: movie, from: "watchlist")
                        if let button = (button.superview?.superview as? TitleCollectionViewCell)?.watchlistButton{
                            button.setTitle("Add to watchlist", for: UIControlState.normal)
                        }
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if let flow = collection.collectionViewLayout as? UICollectionViewFlowLayout{
        //            flow.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        //        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func getTitleCell(for movie: Movie?, in cell : TitleCollectionViewCell, of collectionView : UICollectionView) -> TitleCollectionViewCell{
        cell.titleLabel.text = movie?.title
        cell.genreLabel.text = movie?.genres.map {(g)->String in g.name}.joined(separator: ", ")
        cell.heartLabel.text = movie?.rating
        cell.starLabel.text = "Not available"
        cell.lengthLabel.text = movie?.length
        cell.posterView.image = movie?.image
        
        cell.imageTrailingConstraint.constant = collectionView.bounds.width*0.33
        if collectionView.bounds.width<375{
            cell.imageTrailingConstraint.constant = collectionView.bounds.width*0.39
        }
        
        cell.yearLabel.text = movie?.year
        
        
        if let movie = myMovie{
            if Profile.Instance.contains(movie: movie, in: "watchlist"){
                cell.watchlistButton.setTitle("Remove from watchlist", for: UIControlState.normal)
            }else{
                cell.watchlistButton.setTitle("Add to watchlist", for: UIControlState.normal)
            }
        }
        
        if let movie = myMovie{
            if Profile.Instance.contains(movie: movie, in: "watched"){
                cell.watchedButton.setTitle("Unwatch", for: UIControlState.normal)
            }
            else{
                cell.watchedButton.setTitle("Watch", for: UIControlState.normal)
            }
        }
        
        
        return cell
    }
    
    func getPlotCell(for movie: Movie?, in cell : PlotCollectionViewCell, of collectionView : UICollectionView) -> PlotCollectionViewCell{
        
        cell.titleLabel.text = "Plot"
        
        cell.plotField.text = movie?.overview
        
        return cell
    }
    
    func getCastCell(for movie: Movie?, in cell : PeopleCollectionViewCell, of collectionView : UICollectionView) -> PeopleCollectionViewCell{
        
        cell.titleLabel.text = "Cast"
        
        return cell
    }
    
    func getCrewCell(for movie: Movie?, in cell : PeopleCollectionViewCell, of collectionView : UICollectionView) -> PeopleCollectionViewCell{
        
        cell.titleLabel.text = "Crew"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! TitleCollectionViewCell
            
            return getTitleCell(for: myMovie, in: cell, of: collectionView)
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plotCell", for: indexPath) as! PlotCollectionViewCell
            
            return getPlotCell(for: myMovie, in: cell, of: collectionView)
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath) as! PeopleCollectionViewCell
            
            return getCastCell(for: myMovie, in: cell, of: collectionView)
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath) as! PeopleCollectionViewCell
            
            return getCrewCell(for: myMovie, in: cell, of: collectionView)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        var height : CGFloat
        switch indexPath.row{
        case 0, 1: height = 200
        case 2, 3: height = 252
        default: height = 40
        }
        return CGSize(width: width, height: height)
    }
}

