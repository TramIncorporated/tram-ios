//
//  PeopleCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 10.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! MemberCollectionViewCell
        
        let crewmember = data[indexPath.row].0
        let role = data[indexPath.row].1
        
        cell.imageView.image = crewmember.Image
        cell.nameLabel.text = crewmember.toString()
        cell.roleLabel.text = role
        
        return cell
    }
    
    var data : [(CrewMember, String)] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var peopleCollection: UICollectionView!
}
