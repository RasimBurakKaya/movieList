//
//  FirebaseManager.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 10.07.2025.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    let auth = Auth.auth()
    
    
    func signUp(email: String, password: String, completion: @escaping(Result<User, Error> ) -> Void ) {
        
        auth.createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping(Result< User, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    func signOut() throws {
       try auth.signOut()
    
    }
}
