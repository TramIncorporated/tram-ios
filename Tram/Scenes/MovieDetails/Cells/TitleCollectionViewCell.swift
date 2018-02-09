//
//  TitleCollectionViewCell.swift
//  tram-clean
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
}
