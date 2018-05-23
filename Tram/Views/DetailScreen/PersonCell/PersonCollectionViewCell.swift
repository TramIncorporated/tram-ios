//
//  PersonCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit
import Kingfisher

class PersonCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var job : Credit?
    
    func resetImageView(){
        imageView.layer.borderColor = UIColor(hex: "#d1d1d1").cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit
    }
    
    func fill(filler: PersonCellFiller){
        self.nameLabel.text = filler.perconCellName
        self.roleLabel.text = filler.personCellRole
        
        resetImageView()
        imageView.kf.setImage(with: filler.personCellImage, placeholder: #imageLiteral(resourceName: "person-icon"), options: [.transition(.fade(0.2))], completionHandler: {
            (image, error, cacheType, imageUrl) in
            if let _ = image{
                self.imageView.layer.borderWidth = 0
                self.imageView.contentMode = .scaleAspectFill
            }
        })
    }
    
    func fill(credit: Credit){
        fill(filler: CreditAdapter(credit))
    }
}

protocol PersonCellFiller {
    var perconCellName : String { get }
    var personCellRole : String { get }
    var personCellImage : URL? { get }
}

class CreditAdapter : PersonCellFiller{
    var perconCellName: String {
        get{
            return credit.name
        }
    }
    
    var personCellRole: String {
        get{
            return credit.position
        }
    }
    
    var personCellImage: URL? {
        get{
            return credit.imageUrl
        }
    }
    
    private var credit : Credit
    
    init(_ credit: Credit){
        self.credit = credit
    }
}
