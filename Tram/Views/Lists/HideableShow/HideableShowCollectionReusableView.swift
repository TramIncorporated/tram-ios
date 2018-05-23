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
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var hideButton: UIButton!
    
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    
    var id: Int?
    
    func resetImageView(){
        imageView.layer.borderColor = UIColor(hex: "#d1d1d1").cgColor
        imageView.layer.borderWidth = 1
    }
    
    func fill(filler: SearchCellFiller){
        self.titleLabel.text = filler.searchCellTitle
        self.yearLabel.text = filler.searchCellYear
        self.ratingLabel.text = filler.searchCellHeart
        self.bottomLabel.text = filler.searchCellStars
        
        resetImageView()
        imageView.kf.setImage(with: filler.searchCellImage, placeholder: #imageLiteral(resourceName: "poster-search"), options: [.transition(.fade(0.2))], completionHandler: { (image, _, _, _) in
            if let _ = image{
                self.imageView.layer.borderWidth = 0
            }
        })
    }
}
