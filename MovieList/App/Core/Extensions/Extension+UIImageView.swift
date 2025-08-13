//
//  Extension+UIImageView.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 8.07.2025.
//

import UIKit

extension UIImageView {
    func setImage(url urlString: String, placeholder: UIImage? = nil) {
        
        DispatchQueue.main.async {
            self.image = placeholder
        }
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.downloadTask(with: request) { [weak self] tempURL, response, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            
            guard
                let tempURL = tempURL,
                let data = try? Data(contentsOf: tempURL),
                let downloadedImage = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }
        .resume()
    }
}
