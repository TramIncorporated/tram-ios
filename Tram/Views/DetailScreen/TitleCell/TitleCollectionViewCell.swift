//
//  TitleCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit
import Kingfisher

class TitleCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8 * 2)
    }
    
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

    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    
    func resetImageView(){
        imageView.layer.borderColor = UIColor(hex: "#d1d1d1").cgColor
        imageView.layer.borderWidth = 1
    }
    
    func fill(filler: TitleCellFiller){
        titleLabel.text = filler.titleCellTitle
        yearLabel.text = filler.titleCellYear
        lengthLabel.text = filler.titleCellLength
        genresLabel.text = filler.titleCellGenres
        starLabel.text = filler.titleCellStar
        heartLabel.text = filler.titleCellHeart
        
        resetImageView()
        imageView.kf.setImage(with: filler.titleCellImage, placeholder: #imageLiteral(resourceName: "poster-title"), options: [.transition(.fade(0.2))], completionHandler: { (_, _, _, _) in
            self.imageView.layer.borderWidth = 0
        })
    }
}

protocol TitleCellFiller {
    var titleCellTitle: String { get }
    var titleCellYear: String { get }
    var titleCellLength: String { get }
    var titleCellGenres: String { get }
    var titleCellStar: String { get }
    var titleCellHeart: String { get }
    var titleCellImage: URL? { get }
}

extension Movie : TitleCellFiller{
    var titleCellTitle: String {
        get{
            return title
        }
    }
    
    var titleCellYear: String {
        get{
            return year
        }
    }
    
    var titleCellLength: String {
        get{
            return length
        }
    }
    
    var titleCellGenres: String {
        get {
            return self.genres.map { $0.name }.joined(separator: ", ")
        }
    }
    
    var titleCellStar: String {
        get {
            return "Coming soon"
        }
    }
    
    var titleCellHeart: String {
        get {
            return self.rating
        }
    }
    
    var titleCellImage: URL? {
        get{
            return self.imageUrl
        }
    }
}

extension TVShow : TitleCellFiller {
    var titleCellYear: String {
        return self.year
    }
    
    var titleCellTitle: String {
        get{
            return self.name
        }
    }
    
    var titleCellLength: String {
        get{
            return self.episodeRunTime.map { "\($0)m" }.joined(separator: ", ")
        }
    }
    
    var titleCellGenres: String {
        get{
            return self.genres.map { $0.name }.joined(separator: ", ")
        }
    }
    
    var titleCellStar: String {
        get{
            return "Coming soon"
        }
    }
    
    var titleCellHeart: String {
        get{
            return self.rating
        }
    }
    
    var titleCellImage: URL? {
        get{
            return self.imageUrl
        }
    }
}
