//
//  FavoriteListPresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 25.07.2025.
//

import UIKit

protocol FavoriteListPresenterProtocol {
    func viewFavoriteList()
    func removeFavoriteList(at index: Int)
    func getUserName() -> String
    //func showMovieList()
}

class FavoriteListPresenter: FavoriteListPresenterProtocol {
    var interactor: FavoriteListInteractor?
    var favoriteList: [String] = []
    var view: FavoriteListViewProtocol?
    var router: FavoriteListRouterProtocol?
    
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
        //view?.showFavorities(list: favoriteList)
    }
    
    func getUserName() -> String {
        return interactor?.getCurrentUserName() ?? ""
    }
    
    /*func showMovieList() {
        let currentUserName = interactor?.getCurrentUserName()
        guard let vc = view as? UIViewController else {return}
        router?.navigateToMovieList(from: vc, userName: currentUserName ?? "")
    }*/
}
