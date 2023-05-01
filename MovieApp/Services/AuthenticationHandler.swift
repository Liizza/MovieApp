//
//  LoginHandler.swift
//  MovieApp
//
//  Created by user222465 on 12/11/22.
//

import UIKit
import KeychainSwift

protocol AuthenticationHandler {
    
    var apiService: ApiService? { get set }
    
    func checkLoginStatus(_ completion:@escaping(Bool)->())
    
    func logInAndSavePassword(userName:String,
                              password:String,
                              savePasword:Bool,
                              completion: @escaping((Result<Bool, AuthenticationError>)->()))
    
    func logOut(_ completion: @escaping(Result <DeleteSessionResponse, AuthenticationError>) -> Void)
}
extension AuthenticationHandler {
    
    var keychain: KeychainSwift {
        return KeychainSwift()
    }
    
    func checkLoginStatus(_ completion:@escaping(Bool)->()){
        if let username = keychain.get("username"),let password = keychain.get("password"){
            apiService?.authenticateApiService.authenticate(userName: username, password: password) {
                result in
                switch result{
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
                
            }
        } else{
            completion(false)
        }
    }
    func logInAndSavePassword(userName:String, password:String, savePasword:Bool, completion: @escaping((Result<Bool, AuthenticationError>)->())){
        apiService?.authenticateApiService.authenticate(userName: userName, password: password){ result in
            switch result{
            case .success(_):
                if savePasword {
                    keychain.set(userName, forKey: "username")
                    keychain.set(password, forKey: "password")
                }
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func logOut(_ completion: @escaping(Result <DeleteSessionResponse, AuthenticationError>) -> Void) {
        apiService?.authenticateApiService.deleteSession { response in
            
            switch response {
            case .success(let result):
                keychain.delete("username")
                keychain.delete("password")
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
}


