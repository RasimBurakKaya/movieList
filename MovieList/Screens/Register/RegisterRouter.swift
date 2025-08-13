//
//  RegisterRouter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import Foundation
import UIKit

protocol RegisterRouterProtocol {
    static func createModules() -> UIViewController
    func navigateToLogin(from view: UIViewController, userName: String)
    
}

class RegisterRouter: RegisterRouterProtocol {
    
    static func createModules() -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
            fatalError("view yüklenemedi")
        }
        
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view 
        presenter.router = router
        view.presenter = presenter
        
        return view
        
    }
    
    func navigateToLogin(from view: UIViewController, userName: String) {
        
        /*let loginVC = LoginRouter.createModules(with: userName)
        
        if let navigationController = view.navigationController {
            navigationController.pushViewController(loginVC, animated: true)
            
          }*/
        guard let navigationalController = view.navigationController else {return}
        
        for vc in navigationalController.viewControllers {
            if let loginVC = vc as? LoginViewController {
                //loginVC.didupdateUserName(name: userName)
                navigationalController.popToViewController(loginVC, animated: true)
                break
            }
        }
    
    
    }
        
}
