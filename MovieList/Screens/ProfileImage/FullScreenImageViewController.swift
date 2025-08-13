//
//  FullScreenImageViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 23.07.2025.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.image = image

    }
}
