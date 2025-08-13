//
//  NetworkConfig.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 29.07.2025.
//

import Foundation

struct NetworkConfig  {
    static let baseUrl = URL(string: "https://api.themoviedb.org")!
    let defaultHeaders: [String:String]
}
