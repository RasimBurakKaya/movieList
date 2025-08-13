//
//  ProfilePresenter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 1.08.2025.
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol {
    func getUserName() -> String
    func backToMovieList()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    var name: String?
    var router: ProfileRouterProtocol?
    
    /*func getUserName(){
        name = interactor?.getCurrentUserName() ?? ""
        DispatchQueue.main.async {
            self.view?.didUserNameChanged(name: self.name ?? "")
        }
    }*/
    
    func backToMovieList() {
        name = interactor?.getCurrentUserName() ?? ""
        guard let vc = view as? UIViewController else {return}
        router?.navigateToMovieList(from: vc, userName: name ?? "")
        DispatchQueue.main.async {
            self.view?.didUserNameChanged(name: self.name ?? "")
        }
    }
    
    func getUserName() -> String {
        return interactor?.getCurrentUserName() ?? ""
    }
}
