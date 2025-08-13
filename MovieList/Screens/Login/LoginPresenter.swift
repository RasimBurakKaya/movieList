//
//  LoginPresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import Foundation
import FirebaseAuth
import UIKit

protocol LoginPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailure(error: Error)
    func presentToView(email: String, password: String)
}

class LoginPresenter: LoginPresenterProtocol {
   
    var interactor: LoginInteractorProtocol?
    weak var view: LoginViewProtocol?
    var router: LoginRouter?
    var userName: String?
    
    func loginSuccess() {
        guard let vc = view as? UIViewController,
              let uid = Auth.auth().currentUser?.uid
              
        else {
            return
        }

        UserDefaults.standard.set(uid, forKey: "currentUID")

          
          let key  = usernameKey(for: uid)
          let name = UserDefaults.standard.string(forKey: key) ?? ""
        
        router?.navigateToMovieList(from: vc, userName: name)
    }
    
    func loginFailure(error: any Error) {
        
        view?.invalidCredetentials()
    }
    
    func presentToView(email: String, password: String) {
    
            interactor?.login(email: email, password: password)

    }
    
    func usernameKey(for uid: String) -> String {
      return "currentUserName_\(uid)"
    }
    
}
