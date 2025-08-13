//
//  FavoriteListRouter.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 25.07.2025.
//

import Foundation
import UIKit

protocol FavoriteListRouterProtocol {
    static func createModules(list: [String]) -> UIViewController
}

class FavoriteListRouter: FavoriteListRouterProtocol {
    static func createModules(list: [String]) -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "FavoriteListViewController") as? FavoriteListViewController else {
            fatalError("view bulunuamadı")
        }
        
        let presenter = FavoriteListPresenter()
        let interactor = FavoriteListInteractor()
        
        presenter.favoriteList = list
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
    
    
}
