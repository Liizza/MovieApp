//
//  MovieCellViewModel.swift
//  MovieApp
//
//  Created by Liza on 26.04.2023.
//

import Foundation

protocol MovieCellViewModelProtocol {
    var title: String { get }
    var posterPath: String? { get }
    var description: String { get }
    var rating: String { get }
}

class MovieCellViewModel: MovieCellViewModelProtocol {
    private let movie: MovieProtocol?
    
    init(movie: MovieProtocol?) {
        self.movie = movie
    }
    var title: String {
        return movie?.title ?? ""
    }
    var posterPath: String? {
        return movie?.posterPath
    }
    var description: String {
        return movie?.overview ?? ""
    }
    var rating: String {
        return "⭐️ \(String(format: "%.1f", movie?.voteAverage ?? 0.0))"
    }
}
