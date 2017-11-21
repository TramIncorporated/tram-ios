//
//  SearchCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 19.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
    }

}
