//
//  NetworkUtils.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 29.07.2025.
//

import Foundation

enum NetworkPath: String {
    case http = "http.json"
}

enum Endpoint {
    case ratedMovies(accountID: String)

}
extension Endpoint {
    var path: String {
        switch self {
        case .ratedMovies(let id):
            return "/4/account/\(id)/movie/rated"
        }
    }

}

enum NetworkType {
    case GET
    case POST
 
}
extension NetworkType {
    var type: String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        }
    }
}

enum CustomError: Error {
    case networkError
}
