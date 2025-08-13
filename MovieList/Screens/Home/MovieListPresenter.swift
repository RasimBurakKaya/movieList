//
//  MovieListPresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import Foundation
import UIKit

protocol MovieListPresenterProtocol {
    func fetchedSuccess(movies: [Movie])
    func fetchedFailure(error: Error)
    func viewDidload()
    func navigateOverview(movie: Movie)
    var router: MovieListRouterProtocol? {get set}
    var userName: String? {get}
    func navigateProfile()
    func getUserName() -> String

}

class MovieListPresenter {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var movies: [Movie] = []
    var movie: Movie?
    var router: MovieListRouterProtocol?
    var image: UIImage?
    var userName: String?
    var errorHandler: UINetworkInput?

}
extension MovieListPresenter: MovieListPresenterProtocol {
    func fetchedSuccess(movies: [Movie]) {
        self.movies = movies
        
        DispatchQueue.main.async {
            self.view?.showMovies(movies: movies)
        }
    }
    
    func fetchedFailure(error: any Error) {
        //print("Error: \(error.localizedDescription)")
        errorHandler?.presentAlert(controller: view as! UIAlertController)
    }
    
    
    func viewDidload() {
        interactor?.fetchMovies()
        
    }
    
    func navigateOverview(movie: Movie) {
        guard let vc = view as? MovieListViewController else {return}
        router?.navigateToOverview(from: vc, movie: movie)
    }
    
    func navigateProfile() {
        guard let vc = view as? MovieListViewController else {return}
        let currentName = interactor?.getUserName()
        router?.navigateToProfile(from: vc)
    }
    
    func getUserName() -> String {
        return interactor?.getUserName() ?? ""
    }
    
}
