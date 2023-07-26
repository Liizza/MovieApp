//
//  FavoritesApiService.swift
//  MovieApp
//
//  Created by Liza on 10.04.2023.
//

import Foundation

protocol FavoritesApiService {
    var apiData: ApiData { get set }
    
    init(apiData: ApiData)
    
    func getListOfFavoriteMovies(completion: @escaping(Result<[MovieTMDB], Swift.Error>) -> Void)
    
    func postDeleteFromFavorites(movieId: Int,
                                 mark: Bool,
                                 completion: @escaping(Result <PostFavoriteMovieResponse, Swift.Error>) -> Void)
}

class AlamofireFavoritesApiService: FavoritesApiService, AlamofireHandler {
    var apiData: ApiData
    
    required init(apiData: ApiData) {
        self.apiData = apiData
    }
    func getListOfFavoriteMovies(completion: @escaping(Result<[MovieTMDB], Swift.Error>) -> Void) {
        guard
            let accountId = User.shared.accountId,
            let sessionId = User.shared.sessionId
        else { return }
        getAFRequest(urlRequest: apiData.listOfFavoriteMovie(accountId: accountId, sessionId: sessionId),
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
    func postDeleteFromFavorites(movieId: Int,
                                 mark: Bool,
                                 completion: @escaping(Result <PostFavoriteMovieResponse, Swift.Error>) -> Void) {
        guard
            let accountId = User.shared.accountId,
            let sessionId = User.shared.sessionId
        else { return }
        let requestBody = PostFavoriteMovieRequest(mediaType: "movie", mediaID: movieId, favorite: mark)
        postAFRequest(urlRequest: apiData.addToFavoriteURL(accountId: accountId, sessionId: sessionId), requestBody: requestBody, responseModel: PostFavoriteMovieResponse.self) { response in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
