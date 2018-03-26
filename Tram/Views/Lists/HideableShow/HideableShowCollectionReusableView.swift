//
//  HideableShowCollectionReusableView.swift
//  Tram
//
//  Created by Roman Abuzyarov on 23.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class HideableShowCollectionReusableView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.width
        containerWidthConstraint.constant = screenWidth - (8 * 2)
        resetImage()
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var hideButton: UIButton!
    
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    
    var id: Int?
    
    func resetImage(){
        imageView.layer.borderColor = UIColor(hex: "#d1d1d1").cgColor
        imageView.layer.borderWidth = 1
        imageView.image = #imageLiteral(resourceName: "poster-search")
    }
}
