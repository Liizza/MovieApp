//
//  AlamofireService.swift
//  MovieApp
//
//  Created by Liza on 11.04.2023.
//

import Foundation
import Alamofire

protocol AlamofireHandler {
    
    func postAFRequest<Body: Codable, Model: Codable> (urlRequest: String,
                                                       requestBody: Body,
                                                       responseModel: Model.Type,
                                                       completion: @escaping(Result<Model, Swift.Error>) -> Void)
    
    func getAFRequest<Model: Codable>(urlRequest: String,
                                      responseModel: Model.Type,
                                      completion: @escaping(Result<Model, Swift.Error>) -> Void)
    
    func deleteAFRequest<Body: Codable, Model: Codable>(urlRequest: String,
                                                        requestBody: Body,
                                                        responseModel: Model.Type,
                                                        completion: @escaping(Result<Model, Swift.Error>) -> Void)
}

extension AlamofireHandler {
    func postAFRequest<Body: Codable, Model: Codable> (urlRequest: String,
                                                       requestBody: Body,
                                                       responseModel: Model.Type,
                                                       completion: @escaping(Result<Model, Swift.Error>) -> Void) {

        let request = AF.request(urlRequest,
                                 method: .post,
                                 parameters: requestBody,
                                 encoder: .json,
                                 headers: HTTPHeaders([HTTPHeader(name: "Content-Type",
                                                                  value: "application/json")]))
        request.responseDecodable(of: responseModel.self) { response in
            do {
                let result = try response.result.get()
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    func getAFRequest<Model: Codable>(urlRequest: String,
                                      responseModel: Model.Type,
                                      completion: @escaping(Result<Model, Swift.Error>) -> Void) -> Void {
        let request = AF.request(urlRequest, method: .get)
        request.responseDecodable(of: responseModel.self) { response in
            do {
                let result = try response.result.get()
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    func deleteAFRequest<Body: Codable, Model: Codable>(urlRequest: String,
                                                        requestBody: Body,
                                                        responseModel: Model.Type,
                                                        completion: @escaping(Result<Model, Swift.Error>) -> Void) {
        let request = AF.request(urlRequest,
                                 method: .delete,
                                 parameters: requestBody,
                                 encoder: .json,
                                 headers: HTTPHeaders([HTTPHeader(name: "Content-Type",
                                                                  value: "application/json")]))
        request.responseDecodable(of: responseModel.self) { response in
            do {
                let result = try response.result.get()
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
}
