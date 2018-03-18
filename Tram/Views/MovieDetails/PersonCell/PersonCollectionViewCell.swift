//
//  PersonCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var job : Job?
}
