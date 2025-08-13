//
//  ProfileViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 16.07.2025.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var profilImage: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: CustomTextField!
    
    var firebaseManager = FirebaseManager()
    
    let session = SessionManager()
    
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        loadProfileImage()
        setupUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        profilImage.layer.cornerRadius = profilImage.bounds.width / 2
        profilImage.clipsToBounds = true
        logoutButton.layer.cornerRadius = 12
        
    }
    
    func setupUI() {
        logoutButton.backgroundColor = .red
        logoutButton.tintColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        setupTapGesture()

        profilImage.isUserInteractionEnabled = true
        profilImage.contentMode = .scaleAspectFill
        profilImage.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .black
        
        userNameTextField.text = text
        userNameTextField.textColor = .white
        userNameTextField.backgroundColor = .darkGray
        userNameTextField.addTarget(self, action: #selector(userNameChange), for: .editingChanged)
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        do{
            try firebaseManager.signOut()
            session.clearSession()
            let loginVC = LoginRouter.createModules(with: text ?? "")
            view.window?.rootViewController = UINavigationController(rootViewController: loginVC)
        } catch{
            print("Hata")
        }
        
    }
    
    @IBAction func topMoviesButtonTapped(_ sender: UIButton) {
        
        let movieListVC = MovieListRouter.createModules(userName: userNameTextField.text ?? "")
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
    }
    
    @objc func profileImageTapped() {
        performSegue(withIdentifier: "goToFullScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFullScreen" {
            let destinationVC = segue.destination as! FullScreenImageViewController
            destinationVC.image = profilImage.image
        }
        
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        showPhotoSource()
    }
    
    func showPhotoSource() {
        let sheet = UIAlertController(title: "Edit your profile photo", message: "Please select a source to edit your profile photo.", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.presentImagePicker(source: .camera)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.presentImagePicker(source: .photoLibrary)
            
        }
        
        let removeAction = UIAlertAction(title: "Remove photo", style: .destructive) { _ in
            self.profilImage.image = UIImage(systemName: "person.crop.circle")
            if let uid = Auth.auth().currentUser?.uid {
                let key = self.profileImageKey(for: uid)
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        sheet.addAction(cameraAction)
        sheet.addAction(galleryAction)
        sheet.addAction(cancelAction)
        sheet.addAction(removeAction)
        
        present(sheet, animated: true)
        
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func userNameChange() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let key = "currentUserName_\(uid)"
        let newUserName = userNameTextField.text
        UserDefaults.standard.set(newUserName, forKey: key)
    }

}
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func presentImagePicker(source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        
        if let image = image {
            profilImage.image = image
            saveProfileImage(image)
        }
        picker.dismiss(animated: true)
    }
    
    private func profileImageKey(for uid: String) -> String {
        return "profileImageData_\(uid)"
    }
    
    private func saveProfileImage(_ image: UIImage) {
        guard let uid = UserDefaults.standard.string(forKey: "currentUID"),
              let data = image.jpegData(compressionQuality: 0.8) else { return }
        let key = profileImageKey(for: uid)
        UserDefaults.standard.set(data, forKey: key)
    }

    private func loadProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            profilImage.image = UIImage(systemName: "person.crop.circle")
            return
        }
        let key = profileImageKey(for: uid)
        if let data = UserDefaults.standard.data(forKey: key),
           let img  = UIImage(data: data) {
            profilImage.image = img
        } else {
            profilImage.image = UIImage(systemName: "person.crop.circle")
        }
    }


}
