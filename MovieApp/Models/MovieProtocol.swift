//
//  MovieProtocol.swift
//  MovieApp
//
//  Created by user222465 on 10/25/22.
//

import Foundation

protocol MovieProtocol {
    var adult: Bool { get }
    var backdropPath: String? { get }
    var id: Int { get }
    var title: String { get }
    var originalTitle: String { get }
    var overview: String { get  }
    var posterPath: String? { get  }
    var popularity: Double { get }
    //var releaseDate: String? { get }
    var video: Bool { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
}
