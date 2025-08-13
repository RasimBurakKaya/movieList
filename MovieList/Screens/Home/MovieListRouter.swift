//
//  MovieListRouter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 7.07.2025.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol {
    static func createModules(userName: String) -> UIViewController
    func navigateToOverview(from view: UIViewController, movie: Movie)
}

class MovieListRouter: MovieListRouterProtocol {
    static func createModules(userName: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else{
            fatalError("View bulunumadı")
        }
        
        let presenter = MovieListPresenter()
        //let movie = presenter.movies
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.userName = userName
        interactor.presenter = presenter
        
        return view
        
        
    }
    
    func navigateToOverview(from view: UIViewController, movie: Movie) {
        let vc = OverviewRouter.createModules(movie: movie)
        
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
