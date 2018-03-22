//
//  SegmentedCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class SegmentedCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8 * 2)
    }

    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmented: UISegmentedControl!
}
