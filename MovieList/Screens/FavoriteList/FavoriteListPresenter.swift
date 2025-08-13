//
//  FavoriteListPresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 25.07.2025.
//

protocol FavoriteListPresenterProtocol {
    func viewFavoriteList()
    func removeFavoriteList(at index: Int)
}

class FavoriteListPresenter: FavoriteListPresenterProtocol {
    var interactor: FavoriteListInteractor?
    var favoriteList: [String] = []
    var view: FavoriteListViewProtocol?
    
    func viewFavoriteList() {
        favoriteList = interactor?.fetchFavorites() ?? []
        
        if favoriteList.isEmpty == true {
            view?.showEmptyMessage()
        } else {
            view?.showFavorities(list: favoriteList)
        }
        
    }
    
    func removeFavoriteList(at index: Int) {
        interactor?.removeFavorites(at: index)
        favoriteList.remove(at: index)
        view?.showFavorities(list: favoriteList)
    }
    
}
