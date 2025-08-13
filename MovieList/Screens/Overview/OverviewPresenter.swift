//
//  OverviewPresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 25.07.2025.
//

import Foundation
import UIKit

protocol OverviewPresenterProtocol {
    func favoriteDidChange()
    func favoriteDidTap()
    func showFavoritiesTapped()
    func showMovieList()
    func getUserName() -> String
}

class OverviewPresenter: OverviewPresenterProtocol {
    
    var interactor: OverviewInteractorProtocol?
    weak var view: OverviewViewProtocol?
    var movie: Movie?
    var router: OverviewRouterProtocol?
    
    func favoriteDidChange() {
        let isFav = interactor?.isFavorite(title: movie?.original_title ?? "") ?? false
        view?.updateFavoriteIcon(isFav)
        
    }
    
    func favoriteDidTap() {
        interactor?.toggleFavorite(title: movie?.original_title ?? "")
        favoriteDidChange()
    }
    
    func showFavoritiesTapped() {
        let favorities = interactor?.fetchFavorities() ?? []
        guard let vc = view as? OverviewViewController else {return}
        router?.navigateToFavoriteList(from: vc, favorites: favorities)
    }
    
    func showMovieList() {
        let currentUserName = interactor?.getCurrentUserName()
        guard let vc = view as? UIViewController else {return}
        router?.navigateToMovieList(from: vc, userName: currentUserName ?? "")
        
    }
    
    func getUserName() -> String {
        return interactor?.getCurrentUserName() ?? ""
    }
        
    
}
