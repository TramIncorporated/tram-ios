//
//  SeasonHeaderReusableView.swift
//  Tram
//
//  Created by Roman Abuzyarov on 19.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class SeasonHeaderReusableView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8 * 2)
    }
    @IBOutlet weak var seasonTitleLabel: UILabel!
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
}
