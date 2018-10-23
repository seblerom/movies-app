//
//  MAMoviesListViewController.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 20/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMoviesListViewController: UIViewController {

    
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
        collection.prefetchDataSource = self
        collection.backgroundColor = .black
        collection.keyboardDismissMode = .onDrag
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    private lazy var loadingController : MALoadingViewController = {
       return MALoadingViewController()
    }()
    
    internal lazy var presenter = MAMoviesListPresenter(delegate: self)
    
    override func loadView() {
        super.loadView()
        presenter.searchController = self.searchController
        collectionView.register(MAMovieListCellCollectionViewCell.self, forCellWithReuseIdentifier: MAMovieListCellCollectionViewCell.cellId)
    }
    
    lazy var refresher:UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        presenter.loadConfiguration()
    }
    
    @objc func pullToRefresh()  {
        presenter.pullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setCustomStyle(.large)
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

//MARK: - MASetupable
extension MAMoviesListViewController : MASetupable {
    
    func viewSetup() {
        view.backgroundColor = .black
        title = "Movies"
        addCollectionViewConstraints()
        searchController.searchBar.placeholder = "Search Movies"
        collectionView.refreshControl = self.refresher
    }

}

//MARK: - UICollectionViewDataSource
extension MAMoviesListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAMovieListCellCollectionViewCell.cellId, for: indexPath) as! MAMovieListCellCollectionViewCell
        
        guard let model = presenter.modelForItem(collectionView, cellForItemAt: indexPath), let configuration = presenter.configuration else { return cell }
        
        cell.configure(model, configuration)
        
        return cell

    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MAMoviesListViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.imageSize(width: collectionView.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(collectionView, indexPath)
    }
    
}

//MAR: - UICollectionViewDataSourcePrefetching
extension MAMoviesListViewController : UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        if indexPaths.last!.row >= presenter.currentCount - 1 {
            presenter.loadMovies()
        }
    }

}

//MARK: - UIScrollViewDelegate
extension MAMoviesListViewController : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
}

//MARK: - UISearchResultsUpdating
extension MAMoviesListViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterContent(searchController.searchBar.text)
    }

}

//MARK: - UISearchBarDelegate
extension MAMoviesListViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
    
}

//MARK: - MAMoviesListPresenterDelegate
extension MAMoviesListViewController : MAMoviesListPresenterDelegate {
    
    func willTransition(with model: MADetailMovieModel) {
        let viewController = MAMovieDetailViewController(model: model)
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    
    func loadFilteredMoviesSucces() {
        collectionView.reloadData()
    }
    
    func loadFilteredMoviesError(_ description: String) {
        MAAlert.show(on: self, message: description)
    }
    
    func addLoadingController() {
        add(loadingController)
    }
    
    func removeLoadingController() {
        loadingController.remove()
    }
    
    
    func loadConfigurationSuccess() {
        presenter.loadMovies()
    }
    
    func loadConfigurationError() {
        MAAlert.show(on: self, message: "Configuration error")
    }
    
    
    func loadMoviesSucces() {
        collectionView.reloadData()
        refresher.endRefreshing()
    }
    
    func loadMoviesError(_ description: String) {
        MAAlert.show(on: self, message: description)
        loadingController.remove()
        refresher.endRefreshing()
    }
    
    
}
