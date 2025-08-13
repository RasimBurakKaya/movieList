//
//  ProfileInteractor.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 1.08.2025.
//

import Foundation

protocol ProfileInteractorProtocol {
    func getCurrentUserName() -> String
}

class ProfileInteractor: ProfileInteractorProtocol {
    
    let sessionManager = SessionManager()
    
    func getCurrentUserName() -> String {
        return sessionManager.currentUserName ?? ""
    }
    
    
}
