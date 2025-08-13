//
//  LoginRouter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//
import UIKit

protocol LoginRouterProtocol {
    static func createModules() -> UIViewController
    static func createModules(with userName: String) -> UIViewController
    func navigateToMovieList(from view: UIViewController, userName: String)
}

class LoginRouter: LoginRouterProtocol {
    
    static func createModules() -> UIViewController {
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            guard let vc = storyboard.instantiateViewController(
                    withIdentifier: "LoginViewController") as? LoginViewController
            else { fatalError("LoginVC bulunamadı") }

            let presenter  = LoginPresenter()
            let interactor = LoginInteractor()
            let router     = LoginRouter()

            vc.presenter       = presenter
            presenter.view     = vc
            presenter.interactor = interactor
            presenter.router   = router
            interactor.presenter = presenter

            return vc
        }
    
    static func createModules(with userName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else{
            fatalError("View yüklenemedi")
        }
        
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        presenter.userName = userName
        view.presenter = presenter
        
        return view
    }
    
    func navigateToMovieList(from view: UIViewController, userName: String) {
        
        let viewVC = MovieListRouter.createModules(userName: userName)
        
        if let navigstionController = view.navigationController {
            navigstionController.pushViewController(viewVC, animated: true)
        }
        
    }
    
    
}

