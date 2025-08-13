//
//  SessionManager.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 24.07.2025.
//

import Foundation

protocol SessionManageProtocol {
    var currentUID: String? { get set }
    var currentUserName: String? {get set}
    func getFavoriteTitles() -> [String]
    func toggleFavorite(title: String)
    func removeFavorite(at index: Int)
}

final class SessionManager: SessionManageProtocol {
    
    let defaults = UserDefaults.standard
    let uidKey = "currentUID"
    
    var currentUID: String? {
        get {defaults.string(forKey: uidKey)}
        set {defaults.set(newValue, forKey: uidKey)}
    }
    
    var currentUserName: String? {
        get{
            guard let uid = currentUID else {return nil}
            return defaults.string(forKey: "currentUserName_\(uid)")
        }
        set{
            guard let uid = currentUID else {return}
            return defaults.set(newValue, forKey: "currentUserName_\(uid)")
        }
    }
    
    func favoritesKey() -> String {
        let uid = currentUID ?? "anonymous"
        return "favoriteMovieTitles_\(uid)"
    }
    
    func getFavoriteTitles() -> [String] {
        defaults.stringArray(forKey: favoritesKey()) ?? []
    }
    
    func toggleFavorite(title: String) {
        var list = getFavoriteTitles()
            if let index = list.firstIndex(of: title) {
              list.remove(at: index)
            } else {
              list.append(title)
            }
        defaults.set(list, forKey: favoritesKey())
    }
    
    func removeFavorite(at index: Int) {
        var list = getFavoriteTitles()
        guard index < list.count else { return }
        list.remove(at: index)
        defaults.set(list, forKey: favoritesKey())
    }
    
    func clearSession() {
           defaults.removeObject(forKey: uidKey)
           currentUID = nil
       }
}
