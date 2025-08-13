//
//  FavoriteListInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 25.07.2025.
//
protocol FavoriteListInteractorProtocol {
    func fetchFavorites() -> [String]
    func removeFavorites(at index: Int)
    func getCurrentUserName() -> String
}

class FavoriteListInteractor: FavoriteListInteractorProtocol {

    var session = SessionManager()
    
    func fetchFavorites() -> [String] {
        session.getFavoriteTitles()
    }
    
    func removeFavorites(at index: Int) {
        session.removeFavorite(at: index)
    }
    
    func getCurrentUserName() -> String {
        session.currentUserName ?? ""
    }
}
