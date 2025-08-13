//
//  RegisterInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import Foundation

protocol RegisterInteractorProtocol {
    func register(email: String, password: String)
}
class RegisterInteractor: RegisterInteractorProtocol {
    
    let firebaseManager = FirebaseManager()
    
   // var presenter: RegisterInteractorDelegate?
    var presenter: RegisterPresenterProtocol?
    
    func register(email: String, password: String) {
        firebaseManager.signUp(email: email, password: password) { [weak self] result in
            switch result {
            case.success(let user):
                self?.presenter?.registerSuccess()
            case.failure(let error):
                self?.presenter?.registerFailure(error: error)
            }
        }
    }
    
    
}
