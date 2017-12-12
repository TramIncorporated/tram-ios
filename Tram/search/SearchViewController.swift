//
//  SearchViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    var results = Movies.Instance.movies
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

extension SearchViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = results[indexPath.row].Title
        if let year = results[indexPath.row].Year{
            cell.yearLabel.text = "\(year)"
        }
        cell.ratingLabel.text = results[indexPath.row].HeartRating
        cell.starsLabel.text = results[indexPath.row].Cast.keys.flatMap({ (cm) -> String? in
            cm.toString()
        }).joined(separator: ", ")
        
        cell.posterImageView.image = results[indexPath.row].Image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsController = segue.destination as! MediaPageViewController
        let cell = sender as! SearchCollectionViewCell
        
        let indexPath = collectionView.indexPath(for: cell)
        detailsController.myMovie = results[(indexPath?.row)!]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "searchMovieDetails", sender: collectionView.cellForItem(at: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height : CGFloat = 100
        return CGSize(width: width, height: height)
    }
}
