//
//  PlotCollectionViewCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.02.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class PlotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8*2)
    }
    
    func fill(filler: PlotCellFiller){
        self.sectionTitleLabel.text = filler.plotCellTitle
        self.textView.text = filler.plotCellContent
    }
}

protocol PlotCellFiller {
    var plotCellTitle : String { get }
    var plotCellContent : String { get }
}

extension PlotCellFiller{
    var plotCellTitle : String{
        get{
            return "Plot"
        }
    }
}

extension Movie : PlotCellFiller {
    var plotCellContent: String {
        get{
            if let overview = overview{
                return overview
            }
            return ""
        }
    }
}

extension TVShow : PlotCellFiller {
    var plotCellContent: String {
        get{
            if let overview = overview{
                return overview
            }
            return ""
        }
    }
}
