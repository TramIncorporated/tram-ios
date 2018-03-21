//
//  EpisodeCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 19.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class EpisodeCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8 * 2)
    }
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
}
