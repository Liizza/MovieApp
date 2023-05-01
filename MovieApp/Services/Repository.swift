//
//  Repository.swift
//  MovieApp
//
//  Created by user222465 on 10/24/22.
//

import Foundation

protocol Repository {
    func getMovie(_ completion: @escaping ([MovieRealm]) -> Void) -> Void
}


class RealmRepository: Repository {
    private let apiService:ApiService?
    
    init(apiService:ApiService?) {
        self.apiService = apiService
    }
    
    func getMovie(_ completion: @escaping ([MovieRealm]) ->Void) -> Void {
        apiService?.favoritesApiService.getListOfFavoriteMovies {
            result in
            switch result{
            case .failure(let error):
                let arrayOfMovies = DataManager.shared.getListOfMovies()
                print(error)
                completion(arrayOfMovies ?? [])
            case .success(let results):
                DataManager.shared.deleteMovies() {
                    for movie in results {
                        DataManager.shared.saveMovies(media: movie)
                        let arrayOfMovies = DataManager.shared.getListOfMovies()
                        completion(arrayOfMovies ?? [])
                    }
                }
               
            }
            
        }
        
    }
    
    
}
