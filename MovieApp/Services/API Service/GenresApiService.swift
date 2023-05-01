//
//  GenresApiService.swift
//  MovieApp
//
//  Created by Liza on 08.04.2023.
//

import Foundation

protocol GenresApiService  {
    var apiData:ApiData { get set }
    init(apiData:ApiData)
    
    func getGenresOfMovies(completion:@escaping(Result<[Genre],Swift.Error>)->Void)
    
    func getMoviesByGenre(genreID:Int, completion:@escaping(Result<[MovieTMDB],Swift.Error>)->Void)
    
}

class AlamofireGenresApiService: GenresApiService, AlamofireHandler {
    var apiData: ApiData
    
    required init(apiData: ApiData) {
        self.apiData = apiData
    }
    
    
    func getGenresOfMovies(completion:@escaping(Result<[Genre],Swift.Error>)->Void){
        
        
        getAFRequest(urlRequest: apiData.genresURL(), responseModel: ListOfGenresResponce.self) { response in
            switch response {
            case .success(let result):
                let arrayOfGenres = result.genres
                completion(.success(arrayOfGenres))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
       
    }
    func getMoviesByGenre(genreID:Int, completion:@escaping(Result<[MovieTMDB],Swift.Error>)->Void){
        
        
        
        getAFRequest(urlRequest: apiData.moviesByGenreURL(genreID: genreID), responseModel: MoviesResponse.self) {
            response in
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
