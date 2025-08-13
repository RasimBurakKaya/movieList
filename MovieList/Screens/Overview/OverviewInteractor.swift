//
//  OverviewInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 24.07.2025.
//

import Foundation

protocol OverviewInteractorProtocol {
    func isFavorite(title: String) -> Bool
    func toggleFavorite(title: String)
    func fetchFavorities() -> [String]
    func getCurrentUserName() -> String
}

class OverviewInteractor: OverviewInteractorProtocol {
    
    let session = SessionManager()
    
    func isFavorite(title: String) -> Bool {
        session.getFavoriteTitles().contains(title)
    }
    
    func toggleFavorite(title: String) {
        session.toggleFavorite(title: title)
    }
    
    func fetchFavorities() -> [String] {
        session.getFavoriteTitles()
    }
    
    func getCurrentUserName() -> String{
        return session.currentUserName ?? ""

    }
}
