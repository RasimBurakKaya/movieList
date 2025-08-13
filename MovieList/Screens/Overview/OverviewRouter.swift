//
//  OverviewRouter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 25.07.2025.
//

import Foundation
import UIKit

protocol OverviewRouterProtocol {
    static func createModules(movie: Movie) -> UIViewController
    func navigateToFavoriteList(from view: UIViewController, favorites: [String])
    func navigateToMovieList(from view: UIViewController, userName: String)
}

class OverviewRouter: OverviewRouterProtocol {
    static func createModules(movie: Movie) -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController else {
            fatalError("view bulunamadı")
        }
        
        let presenter = OverviewPresenter()
        let interactor = OverviewInteractor()
        let router = OverviewRouter()
        
        view.movie = movie
        presenter.interactor = interactor
        presenter.view = view
        presenter.movie = movie
        presenter.router = router
        view.presenter = presenter
        
        return view
    }
    
    func navigateToFavoriteList(from view: UIViewController, favorites: [String]) {
        
        let vc = FavoriteListRouter.createModules(list: favorites)
        
        if let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToMovieList(from view: UIViewController, userName: String) {
       /* let vc = MovieListRouter.createModules(userName: userName)
        
        view.navigationController?.pushViewController(vc, animated: true)*/
        
        guard let navigationalController = view.navigationController else {return}
        
        for vc in navigationalController.viewControllers {
            if let movieListVC = vc as? MovieListViewController {
                movieListVC.didupdateUserName(name: userName)
                navigationalController.popToViewController(movieListVC, animated: true)
                break
            }
        }
    }
    
}
