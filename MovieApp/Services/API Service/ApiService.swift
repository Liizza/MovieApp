//
//  ApiService.swift
//  MovieApp
//
//  Created by Liza on 10.04.2023.
//

import Foundation

protocol ApiService {
    var apiData: ApiData { get set }
    
    var authenticateApiService: AuthenticateApiService { get set }
    
    var genresApiService: GenresApiService { get set }
    
    var movieApiService: MovieApiSevice { get set }
    
    var searchApiService: SearchApiService { get set }
    
    var favoritesApiService: FavoritesApiService {get set }
    
    
    
}

class AlamofireApiService: ApiService {
    
    var apiData: ApiData
    
    var authenticateApiService: AuthenticateApiService
    
    var genresApiService: GenresApiService
    
    var movieApiService: MovieApiSevice
    
    var searchApiService: SearchApiService
    
    var favoritesApiService: FavoritesApiService
    
    init(){
        self.apiData = TMDBApiData()
        authenticateApiService = AlamofireAuthenticateApiService(apiData: self.apiData)
        genresApiService = AlamofireGenresApiService(apiData: self.apiData)
        movieApiService = AlamofireMovieApiSevice(apiData: self.apiData)
        searchApiService = AlamofireSearchApiService(apiData: self.apiData)
        favoritesApiService = AlamofireFavoritesApiService(apiData: self.apiData)
        
    }
    
}
