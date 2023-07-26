//
//  LoginApiService.swift
//  MovieApp
//
//  Created by Liza on 08.04.2023.
//

import Foundation

protocol AuthenticateApiService {
    var apiData: ApiData { get set }
    
    init(apiData: ApiData)
    
    func authenticate(userName: String,
                      password: String,
                      completion: @escaping(Result <AccountDetailsResponse, AuthenticationError>) -> Void)
    
    func deleteSession(completion: @escaping(Result <DeleteSessionResponse, AuthenticationError>) -> Void)
}

class AlamofireAuthenticateApiService: AuthenticateApiService, AlamofireHandler {
    var apiData: ApiData
    
    required init(apiData: ApiData) {
        self.apiData = apiData
    }
    func authenticate(userName: String,
                      password: String,
                      completion: @escaping(Result <AccountDetailsResponse, AuthenticationError>) -> Void) {
        getAFRequest(urlRequest: apiData.tokenRequestURL(),
                     responseModel: TokenResponse.self) { [weak self] tokenResponse in
            guard let self else { return }
            switch tokenResponse {
            case .failure(let error):
                print(error)
                completion(.failure(AuthenticationError.noInternetConnection))
            case .success(let tokenResult):
                let token = tokenResult.requestToken
                let requestBody = LoginValidation(username: userName, password: password, requestToken: token)
                self.postAFRequest(urlRequest: self.apiData.validationURL(),
                                   requestBody: requestBody,
                                   responseModel: TokenResponse.self) { validationResponse in
                    switch validationResponse {
                    case .failure(let error):
                        print(error)
                        completion(.failure(AuthenticationError.invalidUserData))
                    case .success(_):
                        let requestBody = TokenRequest(requestToken: token)
                        self.postAFRequest(urlRequest: self.apiData.createSessionURL(),
                                           requestBody: requestBody,
                                           responseModel: SessionResponse.self) { response in
                            switch response {
                            case .failure(let error):
                                print(error)
                                completion(.failure(AuthenticationError.anyError))
                            case .success(let sessionResult):
                                let sessionID = sessionResult.sessionID
                                User.shared.sessionId = sessionID
                                self.getAFRequest(urlRequest: self.apiData.accountDetailsURL(sessionId: sessionID ), responseModel: AccountDetailsResponse.self) { response in
                                    switch response {
                                    case .success(let result):
                                        User.shared.accountId = result.id
                                        completion(.success(result))
                                    case .failure(let error):
                                        print(error)
                                        completion(.failure(AuthenticationError.anyError))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func deleteSession(completion: @escaping(Result <DeleteSessionResponse, AuthenticationError>) -> Void) {
        guard let sessionID = User.shared.sessionId else { return }
        let requestBody = DeleteSessionRequest(sessionId: sessionID)
        deleteAFRequest(urlRequest: self.apiData.deleteSessionURL(),
                        requestBody: requestBody,
                        responseModel: DeleteSessionResponse.self) { response in
            switch response {
            case .success(let result):
                User.shared.sessionId = nil
                User.shared.accountId = nil
                completion(.success(result))
            case .failure(let error):
                print(error)
                completion(.failure(AuthenticationError.anyError))
            }
        }
    }    
}
