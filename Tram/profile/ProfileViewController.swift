//
//  ProfileViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let cell = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? StatsCollectionViewCell{
            cell.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nameCell", for: indexPath) as! NameCollectionViewCell
            
            cell.imageView.image = #imageLiteral(resourceName: "dacre")
            cell.handleLabel.text = "@dacre"
            cell.nameLabel.text = "Dacre Montgomery"
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! StatsCollectionViewCell
            
            cell.data = []
            
            return cell
            
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        var height : CGFloat
        switch indexPath.row{
        case 0: height = 150
        case 1: height = 280
        default: height = 40
        }
        return CGSize(width: width, height: height)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
