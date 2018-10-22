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
    private var moviesModel : MANowPlayingMoviesModel?
    var configuration : MAApiImagesConfigurationModel?
    private var filteredMoviesModel : MANowPlayingMoviesModel?
    var searchController:UISearchController?
    let posterAspectRatio : CGFloat = 9/16
    
    init(delegate:MAMoviesListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func imageSize(width:CGFloat) -> CGSize {
        let half = width / 2
        let height = half / posterAspectRatio
        return CGSize(width: half, height: height)
    }
    
    func numberOfItems() -> Int {
        if isFiltering() {
            return  filteredMoviesModel?.results.count ?? 0
        }
        return moviesModel?.results.count ?? 0
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
        return self.moviesModel?.results[index]
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
    
    func loadMovies() {
        let networkClient = MANetworkClientDecodable<MANowPlayingMoviesModel>()
        networkClient.execute(.nowPlaying()) { (result) in
            switch result{
            case .failure(let error):
                self.delegate.loadMoviesError(error.reason)
            case .success(let response):
                self.moviesModel = response as? MANowPlayingMoviesModel
                self.delegate.loadMoviesSucces()
            }
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
