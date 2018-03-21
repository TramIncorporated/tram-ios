//
//  DetailCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8*2)
    }
}

