//
//  MovieCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 06.01.2018.
//  Copyright © 2018 Roman Abuzyarov. All rights reserved.
//

import UIKit
import Kingfisher

class ShortCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    var id : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.width
        containerWidthConstraint.constant = screenWidth - (8*2)
    }
    
    func resetImageView(){
        imageView.layer.borderColor = UIColor(hex: "#d1d1d1").cgColor
        imageView.layer.borderWidth = 1
    }
    
    func fill(filler: SearchCellFiller){
        self.titleLabel.text = filler.searchCellTitle
        self.yearLabel.text = filler.searchCellYear
        self.ratingLabel.text = filler.searchCellHeart
        self.starsLabel.text = filler.searchCellStars
        self.id = filler.searchCellId
        
        resetImageView()
        imageView.kf.setImage(with: filler.searchCellImage, placeholder: #imageLiteral(resourceName: "poster-search"), options: [.transition(.fade(0.2))], completionHandler: { (image, _, _, _) in
            if let _ = image{
                self.imageView.layer.borderWidth = 0
            }
        })
    }
}

protocol SearchCellFiller {
    var searchCellImage : URL? { get }
    var searchCellTitle : String { get }
    var searchCellYear : String { get }
    var searchCellHeart : String { get }
    var searchCellStars : String { get }
    var searchCellId : Int { get }
}

extension Movie : SearchCellFiller {
    var searchCellId: Int {
        get{
            return id
        }
    }
    
    var searchCellImage: URL? {
        get{
            return self.imageUrl
        }
    }
    
    var searchCellTitle: String {
        get{
            return self.title
        }
    }
    
    var searchCellYear: String {
        get{
            return self.year
        }
    }
    
    var searchCellHeart: String {
        get{
            return self.rating
        }
    }
    
    var searchCellStars: String {
        return self.stars
    }
}

extension TVShow : SearchCellFiller {
    var searchCellId: Int {
        get{
            return id
        }
    }
    
    var searchCellImage: URL? {
        get{
            return self.imageUrl
        }
    }
    
    var searchCellTitle: String {
        get{
            return self.name
        }
    }
    
    var searchCellYear: String {
        get{
            return self.year
        }
    }
    
    var searchCellHeart: String {
        get{
            return self.rating
        }
    }
    
    var searchCellStars: String {
        return self.stars
    }
}
