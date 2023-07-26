//
//  SearchApiService.swift
//  MovieApp
//
//  Created by Liza on 10.04.2023.
//

import Foundation

protocol SearchApiService {
    var apiData: ApiData { get set }
    
    init(apiData: ApiData)
    
    func getSearchResults(searchTerm: String,
                          completion: @escaping(Result <[MovieTMDB], Swift.Error>) -> Void)
}

class AlamofireSearchApiService: SearchApiService, AlamofireHandler {
    var apiData: ApiData
    
    required init(apiData: ApiData) {
        self.apiData = apiData
    }
    func getSearchResults(searchTerm: String,
                          completion: @escaping(Result <[MovieTMDB], Swift.Error>) -> Void) {
        guard
            let searchRequest = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
        else { return }
        getAFRequest(urlRequest: apiData.searchURL(searchTerm: searchRequest),
                     responseModel: MoviesResponse.self) { response in
            switch response {
            case .success(let result):
                let arrayOfMovies = result.results
                completion(.success(arrayOfMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
