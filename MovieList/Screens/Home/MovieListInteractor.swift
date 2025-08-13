//
//  MovieListInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import Foundation

protocol MovieListInteractorProtocol {
    func fetchMovies()
    func getUserName() -> String
}

class MovieListInteractor {
    
    let networkManager = NetworkManager()
    var presenter: MovieListPresenterProtocol?
    let sessionManager = SessionManager()

}
extension MovieListInteractor: MovieListInteractorProtocol {
    
    func fetchMovies() {
        /*networkManager.fetchMovies { [weak self] result in
         switch result {
         case .success(let movie):
         self?.presenter?.fetchedSuccess(movies: movie)
         
         case .failure(let error):
         self?.presenter?.fetchedFailure(error: error)
         print("Error: \(error)")
         }
         }*/
        Task{
            
        let result = await networkManager.fetchMovies()
        
        switch result {
        case .success(let movie):
            presenter?.fetchedSuccess(movies: movie)
        case .failure(let error):
            presenter?.fetchedFailure(error: error)
        }
        
    }
        
 }
    
    func getUserName() -> String {
        return sessionManager.currentUserName ?? ""
    }
    
    
}
