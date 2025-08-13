//
//  LoginInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import Foundation

protocol LoginInteractorProtocol {
    func login(email: String, password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    
    let firebaseManager = FirebaseManager()
    
    weak var presenter: LoginPresenterProtocol?
    
    func login(email: String, password: String) {
        firebaseManager.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case.success(let user):
                self?.presenter?.loginSuccess()
            case.failure(let error):
                self?.presenter?.loginFailure(error: error)
            }
        }
    }
    
}
