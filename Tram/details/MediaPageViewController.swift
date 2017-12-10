//
//  MediaPageViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class MediaPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var myMovie : Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 1
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
            if let year = m?.Year{
                cell.yearLabel.text = "\(year)"
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

