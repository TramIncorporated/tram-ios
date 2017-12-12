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
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! TitleCollectionViewCell
            
            let m = myMovie
            cell.titleLabel.text = m?.Title
            cell.genreLabel.text = m?.Genres.joined(separator: ", ")
            cell.heartLabel.text = m?.HeartRating!
            cell.starLabel.text = m?.StarRating!
            cell.lengthLabel.text = m?.Length!
            cell.posterView.image = m?.Image!
            cell.imageWidthConstraint.constant = (m?.Image?.size.width)!*cell.imageHeightConstraint.constant/(m?.Image?.size.height)! - 4
            cell.imageTrailingConstraint.constant = collectionView.bounds.width*0.35
            
            if let year = m?.Year{
                cell.yearLabel.text = "\(year)"
            }
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plotCell", for: indexPath) as! PlotCollectionViewCell
            
            cell.sectionTitle.text = "Plot"
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height : CGFloat = 200//todo
        return CGSize(width: width, height: height)
    }
}

