//
//  ErrorHandler.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 29.07.2025.
//

import Foundation
import UIKit

protocol UINetworkInput {
    func presentAlert(controller: UIAlertController)
}

final class NetworkErrorHandler {
    
    let viewInput: UINetworkInput
    
    init(viewInput: UINetworkInput) {
        self.viewInput = viewInput
    }
    
    func handleError(error: Error) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewInput.presentAlert(controller: alert)
        
    }
    
}

enum NetworkError: Error {
    case invalidURL, invalidResponse, statusCode(Int), decoding(Error)
}
