//
//  PeopleCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var peopleCollection: UICollectionView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    @IBOutlet weak var containterWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.peopleCollection.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "personCell")
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containterWidthConstraint.constant = screenWidth - (8 * 2)
    }
    
    var people : [Job] = []{
        didSet{
            DispatchQueue.main.async {
                self.peopleCollection.reloadData()
            }
        }
    }
}

extension PeopleCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCollectionViewCell
        
        let job = people[indexPath.row]
        
        cell.nameLabel.text = job.name
        cell.roleLabel.text = job.position
        cell.job = job
        
        cell.resetImage()
        ImageCacheManager.getImageInBackground(url: URL(string: job.imageUrl)) { (image) in
            if cell.job?.id ?? -1 == job.id{
                UIView.animate(withDuration: 0.2) {
                    cell.imageView.alpha = 0
                }
                cell.imageView.layer.borderWidth = 0
                cell.imageView.image = image
                cell.imageView.contentMode = UIViewContentMode.scaleAspectFill
                UIView.animate(withDuration: 0.2) {
                    cell.imageView.alpha = 1
                }
            }
        }
        
        return cell
    }
    
    
}

