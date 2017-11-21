//
//  SearchViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 11.11.2017.
//  Copyright © 2017 Tram, inc. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }



}

extension SearchViewController : UITableViewDelegate{}
extension SearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchProvider().getEntries(for: searchBar.text!).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let res = SearchProvider().getEntries(for: searchBar.text!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.posterImageView.image = res[indexPath.row].posterImage
        cell.titleLabel.text = res[indexPath.row].title
        
        return cell
    }
}
