//
//  MovieDetailsApiService.swift
//  MovieApp
//
//  Created by Liza on 10.04.2023.
//

import Foundation


protocol MovieApiSevice {
    
    var apiData: ApiData { get set }
    init(apiData: ApiData)
    func postAddFavoriteMovie(movieId:Int,
                              mark:Bool,
                              completion:@escaping(Result <PostFavoriteMovieResponse, Swift.Error>)->Void)
    
    func getMovieVideos(movieId:Int,
                        completion:@escaping(Result<[Video], Swift.Error>)-> Void)
    
}



class AlamofireMovieApiSevice: MovieApiSevice, AlamofireHandler {
    var apiData: ApiData
    
    required init(apiData: ApiData) {
        self.apiData = apiData
    }
    
    
    
    func postAddFavoriteMovie(movieId:Int,
                              mark:Bool,
                              completion:@escaping(Result <PostFavoriteMovieResponse, Swift.Error>)->Void){
        
        guard let accountId = User.shared.accountId, let sessionId = User.shared.sessionId else {
            return
        }
        
        
        let requestBody = PostFavoriteMovieRequest(mediaType: "movie", mediaID: movieId, favorite: mark)
        
        postAFRequest(urlRequest: apiData.addToFavoriteURL(accountId: accountId, sessionId: sessionId), requestBody: requestBody, responseModel: PostFavoriteMovieResponse.self) {
            response in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieVideos(movieId:Int,
                        completion:@escaping(Result<[Video], Swift.Error>)-> Void){
        
        getAFRequest(urlRequest: apiData.movieVideosURL(movieId: movieId), responseModel: GetVideosResponse.self) { response in
            switch response {
            case .success(let result):
                let arrayOfVideo = result.results
                completion(.success(arrayOfVideo))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    
    
    
    
}
