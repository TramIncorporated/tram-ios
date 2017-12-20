//
//  SearchViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    override func viewWillDisappear(_ animated: Bool){
        if let cell = movedCell{
            move(cell:cell, to: .right)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = results[indexPath.row].title
        cell.yearLabel.text = results[indexPath.row].year
        cell.ratingLabel.text = results[indexPath.row].rating
        cell.starsLabel.text = "Stars not available"
        
        cell.posterImageView.image = results[indexPath.row].image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = movedCell{
            move(cell: cell, to: .right)
        }
        
        let detailsController = segue.destination as! MediaPageViewController
        let cell = sender as! SearchCollectionViewCell
        
        let indexPath = collectionView.indexPath(for: cell)
        detailsController.myMovie = results[(indexPath?.row)!]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailsSegue", sender: collectionView.cellForItem(at: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height : CGFloat = 100
        return CGSize(width: width, height: height)
    }
    
    private var movedCell : SearchCollectionViewCell? = nil
}

@objc extension SearchViewController : UIGestureRecognizerDelegate{
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        let point = gesture.location(in: self.collectionView)
        
        if (gesture.state == UIGestureRecognizerState.ended) {
            if let indexPath = collectionView.indexPathForItem(at: point) {
                if let cell = self.collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell?{
                    move(cell: cell, to: gesture.direction)
                    
                    if let pCell = self.movedCell{
                        move(cell: pCell, to: .right)
                    }
                    
                    UIView.animate(withDuration: 0.2) {
                        cell.layoutIfNeeded()
                        self.movedCell?.layoutIfNeeded()
                    }
                    
                    self.movedCell = cell
                    
                    if gesture.direction == .right{
                        self.movedCell = nil
                    }
                }
                
            }
        }
    }
    
    func move(cell: SearchCollectionViewCell, to direction : UISwipeGestureRecognizerDirection){
        switch direction {
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
    }
}

extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.results = Movies.Instance.movies.filter {(m)->Bool in
            m.title.contains(" \(searchText)") || m.title.hasPrefix(searchText)
        }
        self.collectionView.reloadSections([0])
    }
}
