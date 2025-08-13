//
//  MovieListEntity.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import Foundation

struct MovieResult: Codable {
    
    let results: [Movie]
    
}

struct Movie: Codable {
    
    let original_title: String
    let overview: String
    let release_date: String
    let vote_average: Double
    let poster_path: String
    let id: Int
}
