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
    func navigate(movie: Movie)
    var router: MovieListRouterProtocol? {get set}
    var userName: String? {get}

}

class MovieListPresenter {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var movies: [Movie] = []
    var movie: Movie?
    var router: MovieListRouterProtocol?
    var image: UIImage?
    var userName: String?
    
}
extension MovieListPresenter: MovieListPresenterProtocol {
    func fetchedSuccess(movies: [Movie]) {
        self.movies = movies
        
        DispatchQueue.main.async {
            self.view?.showMovies(movies: movies)
        }
    }
    
    func fetchedFailure(error: any Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    
    func viewDidload() {
        interactor?.fetchMovies()
        
    }
    
    func navigate(movie: Movie) {
        guard let vc = view as? MovieListViewController else {return}
        router?.navigateToOverview(from: vc, movie: movie)
    }
    
    
}
