//
//  RegisterPresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import Foundation
import FirebaseAuth
import UIKit

protocol RegisterPresenterProtocol {
    func registerSuccess()
    func registerFailure(error: Error)
    func presentToView(email: String, password: String, reTypePassword: String, userName: String)
    func signInTapped()
    
    var router: RegisterRouterProtocol? {get set}
}

class RegisterPresenter: RegisterPresenterProtocol {
    
    var interactor: RegisterInteractorProtocol?
    var router: RegisterRouterProtocol?
    weak var view: RegisterViewProtocol?
    var userName: String?
    
    func registerSuccess() {
        guard let vc = view as? UIViewController,
              let name = userName,
              let uid  = Auth.auth().currentUser?.uid
        else {
        return
    }
        
        let key = usernameKey(for: uid)
        UserDefaults.standard.set(name, forKey: key)
        
        router?.navigateToLogin(from: vc, userName: name)
    }
    
    func registerFailure(error: Error) {
        print("Presenter.registerFailure:", error)
        print("Error: \(error.localizedDescription)")
    }
    
    func presentToView(email: String, password: String, reTypePassword: String, userName: String) {
        
        self.userName = userName
        
        guard password == reTypePassword else {
        view?.passwordMismatchError()
        return
      }
        
        interactor?.register(email: email, password: password)
    }
    
    func signInTapped() {
        guard let vc = view as? UIViewController else {
            return
        }
        router?.navigateToLogin(from: vc, userName: userName ?? "")
    }
    
    func usernameKey(for uid: String) -> String {
      return "currentUserName_\(uid)"
    }

    
}
