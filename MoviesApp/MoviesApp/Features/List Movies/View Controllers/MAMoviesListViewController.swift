//
//  MAMoviesListViewController.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 20/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMoviesListViewController: UIViewController {

    let posterAspectRatio : CGFloat = 9/16
    
    lazy var searchController :UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchBar.tintColor = .white
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .black
        collection.keyboardDismissMode = .onDrag
        return collection
    }()
    
    private var configuration : MAApiImagesConfigurationModel? {
        didSet{
            loadMovies()
        }
    }
    
    private var moviesModel : MANowPlayingMoviesModel? {
        didSet {
            if moviesModel != nil {
                collectionView.reloadData()
            }else {
                //Show error screen
            }
            
        }
    }
    
    private var filteredMovies : MANowPlayingMoviesModel? {
        didSet {
            if filteredMovies != nil {
                collectionView.reloadData()
            }
        }
    }
    
    lazy var loadingController : MALoadingViewController = {
       return MALoadingViewController()
    }()
    
    override func loadView() {
        super.loadView()
        collectionView.register(MAMovieListCellCollectionViewCell.self, forCellWithReuseIdentifier: MAMovieListCellCollectionViewCell.cellId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Movies"
        addCollectionViewConstraints()
        searchController.searchBar.placeholder = "Search Movies"
        loadConfig()
    }
    
    private func loadMovies() {
        
        let networkClient = MANetworkClient()
        networkClient.execute(.nowPlaying()) { (data, error) in
            self.loadingController.remove()
            
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            self.moviesModel = try? jsonDecoder.decode(MANowPlayingMoviesModel.self, from: data)
        }
        
    }
    
    private func loadConfig()  {
        add(loadingController)
        let config = MAConfiguration()
        config.asynchronousConfigurationDataSource { (model) in
            self.configuration = model
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 44)]
        navigationController?.navigationBar.tintColor = .white

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func addCollectionViewConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}

extension MAMoviesListViewController : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
}

//MARK: - UICollectionViewDataSource
extension MAMoviesListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering() {
            return  filteredMovies?.results.count ?? 0
        }
        return moviesModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model : MANowPlayingMoviesResultModel
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAMovieListCellCollectionViewCell.cellId, for: indexPath) as! MAMovieListCellCollectionViewCell
        
        if isFiltering() {
            guard let filteredMoviesModel = filteredMovies?.results[indexPath.row] else { return cell }
            model = filteredMoviesModel
        }else {
            guard let moviesModel = self.moviesModel?.results[indexPath.row] else { return cell }
            model = moviesModel
        }
        
        guard let configuration = self.configuration else { return cell }
        
        
        cell.configure(model, configuration)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MAMoviesListViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2
        let height = width / posterAspectRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MAMovieListCellCollectionViewCell, let resultModel = cell.resultModel,let configuration = cell.configuration else { return }

        let model = MADetailMovieModel(path:resultModel.backDropPath,title:resultModel.title,plot:resultModel.overview,configuration:configuration)
        let viewController = MAMovieDetailViewController(model: model)
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
    }
    
}

//MARK: - UISearchResultsUpdating
extension MAMoviesListViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

}

extension MAMoviesListViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
    
}

extension MAMoviesListViewController {
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        if searchText.count > 2 {
            let networkClient = MANetworkClient()
            add(loadingController)
            networkClient.execute(.search(searchText)) { (data, error) in
                self.loadingController.remove()
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    self.filteredMovies = try? jsonDecoder.decode(MANowPlayingMoviesModel.self, from: data)
                }
                
            }
        }

    }
}
