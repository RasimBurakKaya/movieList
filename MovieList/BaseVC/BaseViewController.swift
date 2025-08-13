//
//  BaseViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 31.07.2025.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
   
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
