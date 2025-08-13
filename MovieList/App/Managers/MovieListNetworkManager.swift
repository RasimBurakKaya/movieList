//
//  MovieListNetworkManager.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import Foundation
import UIKit

class NetworkManager {
    
    var mainNetworkManager: INetworkManager = MainNetworkManager()
    let accountId = "6867691fc6d4322bdb991f74"
    
    func fetchMovies() async -> Result<[Movie], Error> {

        let result: Result<MovieResult?, Error> = await mainNetworkManager.fetch(.ratedMovies(accountID: accountId), method: .GET, type: MovieResult.self)

        switch result {
        case .success(let movieResult):
            return .success(movieResult?.results ?? [])
        case .failure(let error):
            return .failure(CustomError.networkError)
        }
    }
    
    /*func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {

        let url = URL(string: "https://api.themoviedb.org/4/account/6867691fc6d4322bdb991f74/movie/rated")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")

        if let jwt = TokenProvider.shared.load() {
            request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        } else {
            print("JWT bulunamadı, isteğe token eklenmedi.")
        }
        
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

    }*/

}
