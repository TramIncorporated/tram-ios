//
//  TitleCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.12.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {    
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
}
