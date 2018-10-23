//
//  MAMoviesListPresenter.swift
//  MoviesApp
//
//  Created by Sebastian Leon romero on 22/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

protocol MAMoviesListPresenterDelegate {
    func loadConfigurationSuccess()
    func loadConfigurationError()
    func loadMoviesSucces()
    func loadMoviesError(_ description:String)
    func loadFilteredMoviesSucces()
    func loadFilteredMoviesError(_ description:String)
    func addLoadingController()
    func removeLoadingController()
    func willTransition(with model:MADetailMovieModel)
}

class MAMoviesListPresenter {
    
    let delegate : MAMoviesListPresenterDelegate
    internal var moviesModel : MANowPlayingMoviesModel?
    private var moviesResult = [MANowPlayingMoviesResultModel]()
    var configuration : MAApiImagesConfigurationModel?
    internal var filteredMoviesModel : MANowPlayingMoviesModel?
    private var isFetchInProgress = false
    var searchController:UISearchController?
    let posterAspectRatio : CGFloat = 9/16
    var hasReachedEnd = false
    
    private var page = 1
    private var totalPages = 0
    
    init(delegate:MAMoviesListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func imageSize(width:CGFloat) -> CGSize {
        let half = width / 2
        let height = half / posterAspectRatio
        return CGSize(width: half, height: height)
    }
    
    var currentCount: Int {
        return moviesResult.count
    }
    
    func numberOfItems() -> Int {
        if isFiltering() {
            return  filteredMoviesModel?.results.count ?? 0
        }
        return moviesResult.count
    }
    
    func isFiltering() -> Bool {
        return searchController!.isActive && !searchBarIsEmpty()
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController?.searchBar.text?.isEmpty ?? true
    }
    
    func filtered(at index:Int) -> MANowPlayingMoviesResultModel? {
        return self.filteredMoviesModel?.results[index]
    }
    
    func movie(at index:Int) -> MANowPlayingMoviesResultModel? {
        return moviesResult[index]
    }
    
    func modelForItem(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MANowPlayingMoviesResultModel? {
        
        var model : MANowPlayingMoviesResultModel?
        
        if isFiltering(){
            guard let filteredMoviesModel = filtered(at: indexPath.row) else { return model }
            model = filteredMoviesModel
        }else {
            guard let moviesModel = movie(at: indexPath.row) else { return model }
            model = moviesModel
        }

        return model
    }
    
    func didSelect(_ collectionView:UICollectionView,_ indexPath:IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MAMovieListCellCollectionViewCell, let resultModel = cell.resultModel,let configuration = cell.configuration else { return }
        
        let model = MADetailMovieModel(path:resultModel.backDropPath,title:resultModel.title,plot:resultModel.overview,configuration:configuration)
        
        self.delegate.willTransition(with: model)

    }
    
}

//MARK: - Network request
extension MAMoviesListPresenter {
    
    func pullToRefresh()  {
        moviesResult = [MANowPlayingMoviesResultModel]()
        page = 1
        totalPages = 0
        hasReachedEnd = false
        loadMovies()
    }
    
    func loadMovies() {
        
        guard !isFetchInProgress && !hasReachedEnd else {
            return
        }
        
        isFetchInProgress = true
        
        let networkClient = MANetworkClientDecodable<MANowPlayingMoviesModel>()
        networkClient.execute(.nowPlaying(self.page)) { (result) in
            switch result{
            case .failure(let error):
                self.delegate.loadMoviesError(error.reason)
                self.isFetchInProgress = false
            case .success(let response):
                self.isFetchInProgress = false
                self.moviesModel = response as? MANowPlayingMoviesModel
                self.movies(moviesModel: response as! MANowPlayingMoviesModel)
                self.delegate.loadMoviesSucces()
            }
        }
    }
    
    private func movies(moviesModel:MANowPlayingMoviesModel) {
        moviesResult.append(contentsOf: moviesModel.results)
        page += 1
        totalPages = moviesModel.totalPages
        if totalPages == page{
            hasReachedEnd = true
        }
    }
    
    func loadConfiguration()  {
        let config = MAConfiguration()
        self.delegate.addLoadingController()
        config.asynchronousConfigurationDataSource { (model) in
            self.delegate.removeLoadingController()
            guard let model = model else {
                self.delegate.loadConfigurationError()
                return
            }
            self.configuration = model
            self.delegate.loadConfigurationSuccess()
        }
    }
    
    func filterContent(_ searchText: String?) {
        
        if let search = searchText,search.count > 2 {
            let networkClient = MANetworkClientDecodable<MANowPlayingMoviesModel>()
            self.delegate.addLoadingController()
            networkClient.execute(.search(search)) { (result) in
                self.delegate.removeLoadingController()
                switch result{
                case .failure(let error):
                    self.delegate.loadFilteredMoviesError(error.reason)
                case .success(let response):
                    self.filteredMoviesModel = response as? MANowPlayingMoviesModel
                    self.delegate.loadFilteredMoviesSucces()
                }
            }
        }
    }
}
