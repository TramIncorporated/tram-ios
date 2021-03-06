//
//  ProfileSceneViewController.swift
//  Tram
//
//  Created by Roman Abuzyarov on 21.03.2018.
//  Copyright (c) 2018 Tram, inc.. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProfileSceneDisplayLogic: class
{
    func displayUser(viewModel: ProfileScene.GetUser.ViewModel)
}

class ProfileSceneViewController: UIViewController, ProfileSceneDisplayLogic
{
    var interactor: ProfileSceneBusinessLogic?
    var router: (NSObjectProtocol & ProfileSceneRoutingLogic & ProfileSceneDataPassing)?
    var user : User?
    
    enum Scope{
        case Movie
        case TVShow
    }
    
    var scope = Scope.Movie
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ProfileSceneInteractor()
        let presenter = ProfileScenePresenter()
        let router = ProfileSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView?.register(UINib(nibName: "BarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "barCell")
        self.collectionView?.register(UINib(nibName: "AccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "accountCell")
        self.collectionView?.register(UINib(nibName: "ShortCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shortCell")
        self.collectionView?.register(UINib(nibName: "SegmentedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "segmentedCell")
        self.collectionView?.register(UINib(nibName: "ListHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestUser()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func requestUser()
    {
        let request = ProfileScene.GetUser.Request()
        interactor?.getUser(request: request)
    }
    
    func displayUser(viewModel: ProfileScene.GetUser.ViewModel)
    {
        user = viewModel.user
        if let user = user{
            movies[0].setItems(items: user.movieWatchlist ?? [])
            movies[1].setItems(items: user.movieWatched ?? [])
            shows[0].setItems(items: user.showWatchlist ?? [])
            shows[1].setItems(items: user.showWatched ?? [])
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    var movies = [HideableDataSource(items: [Movie](), hidden: false),
                  HideableDataSource(items: [Movie](), hidden: false)]
    
    var shows = [HideableDataSource(items: [TVShow](), hidden: false),
                 HideableDataSource(items: [TVShow](), hidden: false)]
}

extension ProfileSceneViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let _ = user{
            return 3
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let user = user{
            switch section{
            case 0:
                return (1 + user.bars.count + 1)
            default:
                switch scope{
                case .Movie:
                    return movies[section-1].dataSource.count
                case .TVShow:
                    return shows[section-1].dataSource.count
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? ListHeaderCollectionReusableView{
            cell.hideButton.removeTarget(nil, action: nil, for: .allEvents)
            cell.hideButton.addTarget(self, action: #selector(hidePressed(_:)), for: .touchUpInside)
            switch indexPath.section{
            case 0:
                ()
            case 1:
                cell.sectionTitle.text = "Watchlist"
                cell.hideButton.tag = 0
            case 2:
                cell.sectionTitle.text = "Watched"
                cell.hideButton.tag = 1
            default:
                ()
            }
            
            switch scope{
            case .Movie:
                cell.hideButton.rotate(hidden: movies[indexPath.section-1].hidden, animate: false)
            case .TVShow:
                cell.hideButton.rotate(hidden: shows[indexPath.section-1].hidden, animate: false)
            }
            
            return cell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let user = user else { return UICollectionViewCell() }
        switch indexPath.section{
        case 0:
            switch indexPath.row {
            case 0:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as? AccountCollectionViewCell{
                    cell.handleLabel.text = user.handle
                    cell.nameLabel.text = user.name
                    
                    return cell
                }
                
            case 1..<(1+user.bars.count):
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barCell", for: indexPath) as? BarCollectionViewCell{
                    
                    let bar = user.bars[indexPath.row-1]
                    
                    cell.titleLabel.text = bar.title
                    cell.progressLabel.text = bar.progressText
                    cell.progressView.progress = bar.progress
                    
                    return cell
                }
            case 1+user.bars.count:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segmentedCell", for: indexPath) as? SegmentedCollectionViewCell{
                    
                    cell.segmented.removeTarget(nil, action: nil, for: .allEvents)
                    cell.segmented.addTarget(self, action: #selector(segmentedChanged(_:)), for: .valueChanged)
                    let blue = UIColor(red: 50.0/255, green: 85.0/255, blue: 219.0/255, alpha: 1)
                    let gray = UIColor.black
                    let font = UIFont(name: "HelveticaNeue-Thin", size: 16.0)!
                    var attributes = [NSAttributedStringKey.foregroundColor : blue,
                                      NSAttributedStringKey.font : font]
                    cell.segmented.setTitleTextAttributes(attributes, for: .selected)
                    attributes = [NSAttributedStringKey.foregroundColor : gray,
                                  NSAttributedStringKey.font : font]
                    cell.segmented.setTitleTextAttributes(attributes, for: .normal)
                    
                    return cell
                }
                
            default:
                return UICollectionViewCell()
            }
        default:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shortCell", for: indexPath) as? ShortCollectionViewCell{
                switch scope{
                case .Movie:
                    let item = movies[indexPath.section-1].dataSource[indexPath.row]
                    cell.fill(filler: item)
                case .TVShow:
                    let item = shows[indexPath.section-1].dataSource[indexPath.row]
                    cell.fill(filler: item)
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: collectionView.frame.width - (8*2), height: 0)
        }
        else{
            return CGSize(width: collectionView.frame.width - (8*2), height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - (8*2)
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                return CGSize(width: width, height: 180)
            case 1..<(1+(user?.bars.count ?? 0)):
                return CGSize(width: width, height: 60)
            default:
                return CGSize(width: width, height: 60)
            }
        default:
            return CGSize(width: width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            return
        }
        switch scope {
        case .Movie:
            let movie = movies[indexPath.section-1].dataSource[indexPath.row]
            let movieDetails = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
            (movieDetails?.interactor as? MovieDetailsInteractor)?.movie = movie
            self.show(movieDetails!, sender: self)
        case .TVShow:
            let show = shows[indexPath.section-1].dataSource[indexPath.row]
            let showDetails = storyboard?.instantiateViewController(withIdentifier: "TVShowDetailsViewController") as? TVShowDetailsViewController
            (showDetails?.interactor as? TVShowDetailsInteractor)?.show = show
            self.show(showDetails!, sender: self)
        }
    }
}

extension ProfileSceneViewController {
    @objc func segmentedChanged(_ sender: Any){
        if let sender = sender as? UISegmentedControl{
            switch sender.selectedSegmentIndex{
            case 0:
                scope = .Movie
            case 1:
                scope = .TVShow
            default:
                ()
            }
            collectionView.reloadSections([1,2])
        }
    }
    
    @objc func hidePressed(_ sender: Any){
        if let sender = sender as? UIButton{
            
            switch scope{
            case .Movie:
                let data = movies[sender.tag]
                let ip = data.indexPaths(for: sender.tag+1)
                if data.hidden{
                    data.toggle()
                    collectionView.insertItems(at: ip)
                }
                else{
                    data.toggle()
                    collectionView.deleteItems(at: ip)
                }
            case .TVShow:
                let data = shows[sender.tag]
                let ip = data.indexPaths(for: sender.tag+1)
                if data.hidden{
                    data.toggle()
                    collectionView.insertItems(at: ip)
                }
                else{
                    data.toggle()
                    collectionView.deleteItems(at: ip)
                }
            }
            
            sender.rotate(animate: true)
        }
    }
}
