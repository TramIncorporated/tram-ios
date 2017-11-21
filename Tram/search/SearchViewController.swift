//
//  SearchViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    
    var ar = [(title: "Blade", year: "(1998)", perc: "71%", stars: "Wesley Snipes, Stephen Dorff", file: "/Users/romanabuzyarov/Downloads/Blade_movie.jpg")]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // right swipe gesture
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SearchViewController.handleSwipe(gesture:)))
        swipeLeftRecognizer.direction = .left
        swipeLeftRecognizer.delegate = self
        self.collectionView.addGestureRecognizer(swipeLeftRecognizer)
        
        // right swipe gesture
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SearchViewController.handleSwipe(gesture:)))
        swipeRightRecognizer.direction = .right
        swipeRightRecognizer.delegate = self
        self.collectionView.addGestureRecognizer(swipeRightRecognizer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

@objc extension SearchViewController : UIGestureRecognizerDelegate{
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        let point = gesture.location(in: self.collectionView)
        if (gesture.state == UIGestureRecognizerState.ended) {
            if let indexPath = collectionView.indexPathForItem(at: point) {
                if let cell = self.collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell?{
                    switch gesture.direction {
                    case .left:
                        if cell.leftSideConstraint.constant == 0{
                            cell.leftSideConstraint.constant = -124
                        }
                        if cell.rightSideConstraint.constant == 0{
                            cell.rightSideConstraint.constant = 124
                        }
                    default:
                        if cell.leftSideConstraint.constant == -124{
                            cell.leftSideConstraint.constant = 0
                        }
                        if cell.rightSideConstraint.constant == 124{
                            cell.rightSideConstraint.constant = 0
                        }
                    }
                    UIView.animate(withDuration: 0.2) {
                        cell.layoutIfNeeded()
                    }
                }
                
            }
        }
    }
}

extension SearchViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ar.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = ar[indexPath.row].title
        cell.yearLabel.text = ar[indexPath.row].year
        
        cell.ratingLabel.text = ar[indexPath.row].perc
        cell.starsLabel.text = ar[indexPath.row].stars
        
        cell.posterImageView.image = UIImage(named: ar[indexPath.row].file)
        
        return cell
    }
}
