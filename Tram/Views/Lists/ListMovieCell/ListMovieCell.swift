//
//  ListMovieCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 17.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class ListMovieCell: UICollectionViewCell {
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8*2)
    }
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
}
