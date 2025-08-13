//
//  ProfileRouter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 1.08.2025.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol {
    static func createModules() -> UIViewController
    func navigateToMovieList(from view: UIViewController, userName: String)
}

class ProfileRouter: ProfileRouterProtocol {
    static func createModules() -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {
            fatalError("view bulunamadı")
        }
        
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
        
        return view
    }
    
    func navigateToMovieList(from view: UIViewController, userName: String) {
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
