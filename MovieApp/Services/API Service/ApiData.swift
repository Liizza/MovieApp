//
//  ApiData.swift
//  MovieApp
//
//  Created by Liza on 10.04.2023.
//

import Foundation

protocol ApiData {
    var apiKey: String { get }
    func tokenRequestURL() -> String
    func validationURL() -> String
    func createSessionURL() -> String
    func accountDetailsURL(sessionId: String) -> String
    func deleteSessionURL() -> String
    func genresURL() -> String
    func moviesByGenreURL(genreID: Int) -> String
    func addToFavoriteURL(accountId: Int, sessionId: String) -> String
    func movieVideosURL(movieId: Int) -> String
    func searchURL(searchTerm: String) -> String
    func listOfFavoriteMovie(accountId: Int, sessionId: String) -> String
}

class TMDBApiData: ApiData {
    var apiKey: String = "bb01e0fd27b6316b2e11f2a45d43b148"
    func tokenRequestURL() -> String {
        return "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
    }
    func validationURL() -> String {
        return "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(apiKey)"
    }
    func createSessionURL() -> String {
        return "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)"
    }
    func accountDetailsURL(sessionId: String) -> String {
        return "https://api.themoviedb.org/3/account?api_key=\(apiKey)&session_id=\(sessionId)"
    }
    func deleteSessionURL() -> String {
        return "https://api.themoviedb.org/3/authentication/session?api_key=\(apiKey)"
    }
    func genresURL() -> String {
        return "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)"
    }
    func moviesByGenreURL(genreID: Int) -> String {
        return "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=\(genreID)&sort_by=popularity.desc"
    }
    func addToFavoriteURL(accountId: Int, sessionId: String) -> String {
        return "https://api.themoviedb.org/3/account/\(accountId)/favorite?api_key=\(apiKey)&session_id=\(sessionId)"
    }
    func movieVideosURL(movieId: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
    }
    func searchURL(searchTerm: String) -> String {
        return "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchTerm)&page=1"
    }
    func listOfFavoriteMovie(accountId: Int, sessionId: String) -> String {
        return "https://api.themoviedb.org/3/account/\(accountId)/favorite/movies?api_key=\(apiKey)&session_id=\(sessionId)&sort_by=created_at.desc&page=1"
    }
}
