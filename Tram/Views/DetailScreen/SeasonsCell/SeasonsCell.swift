//
//  SeasonsCell.swift
//  Tram
//
//  Created by Roman Abuzyarov on 18.03.2018.
//  Copyright © 2018 Tram, inc. All rights reserved.
//

import UIKit

class SeasonsCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerWidthConstraint.constant = screenWidth - (8 * 2)
        
        self.collectionView?.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellWithReuseIdentifier: "episodeCell")
        self.collectionView?.register(UINib(nibName: "SeasonHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "seasonHeader")
        
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: (self.collectionView?.frame.width)!-(8*2), height: 50)
            flowLayout.headerReferenceSize = CGSize(width: (self.collectionView?.frame.width)!-(8*2), height: 50)
        }
        recalculateHight()
        hideButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    private var hideableCount : Int? = 0
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    @IBAction func hidePressed(_ sender: Any) {
        if let _ = hideableCount{
            hideableCount = nil
        }
        else{
            hideableCount = 0
        }
        
        recalculateHight()
        collectionView.reloadData()
    }
    var data = [Int:(season: Season, episodes: HideableDataSource<Episode>)]()
    
    func recalculateHight(){
        var height : Int
        if let _ = hideableCount{
            height = 40
        }
        else{
            height = data.reduce(40, { (sum, pair) in
                sum + 50 + pair.value.episodes.dataSource.count * 50
            })
        }
        
        self.containerHeightConstraint.constant = CGFloat(height)
        self.bounds.size.height = CGFloat(height)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func initData(from show: TVShow){
        for season in show.seasons{
            data[season.seasonNumber] = (season, HideableDataSource(items: season.episodes, hidden: true))
            DispatchQueue.main.async {
                self.recalculateHight()
                self.collectionView.reloadData()
            }
            
            //            season.loadEpisodes(onSuccess: { (s) in
            //                self.data[s.seasonNumber] = (s, HideableDataSource(items: s.episodes, hidden: true))
            //                DispatchQueue.main.async {
            //                    self.collectionView.reloadData()
            //                }
            //            })
        }
    }
}

extension SeasonsCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return hideableCount ?? data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return data[section]?.episodes.dataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodeCell", for: indexPath) as? EpisodeCell{
            if let item = data[indexPath.section]?.episodes.dataSource[indexPath.row]{
                cell.episodeNumberLabel.text = "Episode \(item.episodeNumber)"
                cell.titleLabel.text = item.name
                cell.airDateLabel.text = item.dateString(format: "dd.mm.yyyy")
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "seasonHeader", for: indexPath) as? SeasonHeaderReusableView{
            if let data = data[indexPath.section]{
                header.seasonTitleLabel.text = data.season.name
                let transform = data.episodes.hidden ? CGFloat.pi : 0
                header.hideButton.transform = CGAffineTransform(rotationAngle: transform)
                //todo
            }
            return header
        }
        return UICollectionReusableView()
    }
}

