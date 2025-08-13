//
//  LoginViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func invalidCredetentials()
}

class LoginViewController: BaseViewController, LoginViewProtocol {
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGesture()
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        emailTextField.text = "test16@gmail.com"
        passwordTextField.text = "Password16"
        
        setupUI()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        presenter?.presentToView(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let registerVC = RegisterRouter.createModules()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func setupUI() {
        loginLabel.textColor = .black
        infoLabel.textColor = .black
        
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        loginButton.backgroundColor = .black
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 12
        
        haveAccountLabel.textColor = .black
    }
    
    func invalidCredetentials() {
        let alert = UIAlertController(title: "Invalid Credentials", message: "Your email or password is wrong. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    /*func setupTapGesture() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
     view.addGestureRecognizer(tapGesture)
     }
     
     @objc func dismissKeyboard() {
     view.endEditing(true)
     }*/
}
     

