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
        cell.titleLabel.text = movie?.Title
        cell.genreLabel.text = movie?.Genres.joined(separator: ", ")
        cell.heartLabel.text = movie?.HeartRating!
        cell.starLabel.text = movie?.StarRating!
        cell.lengthLabel.text = movie?.Length!
        cell.posterView.image = movie?.Image!
        
        cell.imageTrailingConstraint.constant = collectionView.bounds.width*0.33
        if collectionView.bounds.width<375{
            cell.imageTrailingConstraint.constant = collectionView.bounds.width*0.39
        }
        
        if let year = movie?.Year{
            cell.yearLabel.text = "\(year)"
        }
        
        return cell
    }
    
    func getPlotCell(for movie: Movie?, in cell : PlotCollectionViewCell, of collectionView : UICollectionView) -> PlotCollectionViewCell{
        
        cell.titleLabel.text = "Plot"
        
        if let plot = movie?.Plot{
            cell.plotField.text = plot
        }
        
        return cell
    }
    
    func getCastCell(for movie: Movie?, in cell : PeopleCollectionViewCell, of collectionView : UICollectionView) -> PeopleCollectionViewCell{
        
        cell.titleLabel.text = "Cast"
        cell.data = (movie?.Cast.map({ (pair) -> (CrewMember, String) in
            return (pair.person, pair.role)
        }))!
        
        
        return cell
    }
    
    func getCrewCell(for movie: Movie?, in cell : PeopleCollectionViewCell, of collectionView : UICollectionView) -> PeopleCollectionViewCell{
        
        cell.titleLabel.text = "Crew"
        cell.data = (movie?.Crew.map({ (pair) -> (CrewMember, String) in
            return (pair.person, pair.role)
        }))!
        
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

