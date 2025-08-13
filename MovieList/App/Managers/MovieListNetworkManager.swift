//
//  MovieListNetworkManager.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import Foundation
import UIKit

class NetworkManager {
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {

        let url = URL(string: "https://api.themoviedb.org/4/account/6867691fc6d4322bdb991f74/movie/rated")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "page", value: "1"),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "sort_by", value: "created_at.asc"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMzcyNWY1MTM2MWU4YTFiOTViMmQwYWE2OWQyNGYzNyIsIm5iZiI6MTc1MTYwNzU4My44NzYsInN1YiI6IjY4Njc2OTFmYzZkNDMyMmJkYjk5MWY3NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m6Foqw3lsnQegRjCP62faLt1y22KWXj5OH9_JWhj8kU"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "no data", code: 0)))
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) {
               print("JSON response:\n", json)
             }
            
            do{
                let movies = try JSONDecoder().decode(MovieResult.self, from: data)
                completion(.success(movies.results))
            }catch{
                print("decode error: ", error)
                completion(.failure(error))
            }
        }
        
        task.resume()

    }

}
