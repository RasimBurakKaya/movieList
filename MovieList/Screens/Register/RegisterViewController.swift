//
//  RegisterViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func passwordMismatchError()
    
}

class RegisterViewController: UIViewController, RegisterViewProtocol {
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: CustomTextField!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var reTypePasswordTextField: CustomTextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var haveLoginLabel: UILabel!
    
    @IBOutlet weak var loginLabel: UIButton!
    
    var presenter: RegisterPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        setupTapGesture()
        setupUI()

    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        presenter?.presentToView(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", reTypePassword: reTypePasswordTextField.text ?? "", userName: userNameTextField.text ?? "")
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        presenter?.signInTapped()
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        registerLabel.textColor = .black
        infoLabel.textColor = .black
        
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        reTypePasswordTextField.placeholder = "ReType Password"
        userNameTextField.placeholder = "User Name"
        
        registerButton.backgroundColor = .black
        registerButton.tintColor = .white
        registerButton.layer.cornerRadius = 12
        
        haveLoginLabel.textColor = .black
        
    }
    
    func passwordMismatchError() {
        let alert = UIAlertController(title: "Password mismatch error", message: "Your Password and retype password are not matched", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
