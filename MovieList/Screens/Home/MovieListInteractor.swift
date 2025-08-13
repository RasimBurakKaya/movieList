//
//  MovieListInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import Foundation

protocol MovieListInteractorProtocol {
    func fetchMovies()
}

class MovieListInteractor {
    
    let networkManager = NetworkManager()
    var presenter: MovieListPresenterProtocol?

}
extension MovieListInteractor: MovieListInteractorProtocol {
    
    func fetchMovies() {
        networkManager.fetchMovies { [weak self] result in
            switch result {
            case .success(let movie):
                self?.presenter?.fetchedSuccess(movies: movie)
            
            case .failure(let error):
                self?.presenter?.fetchedFailure(error: error)
                print("Error: \(error)")
            }
        }
    }
    
    
}
