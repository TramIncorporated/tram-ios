//
//  PersonCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetImage()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var job : Job?
    
    func resetImage(){
        imageView.layer.borderColor = UIColor(hex: "#d1d1d1").cgColor
        imageView.layer.borderWidth = 1
        imageView.image = #imageLiteral(resourceName: "person-icon")
        imageView.contentMode = .scaleAspectFit
    }
}
