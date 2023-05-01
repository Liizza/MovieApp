//
//  MovieRealm.swift
//  MovieApp
//
//  Created by user222465 on 10/24/22.
//

import Foundation
import RealmSwift

class MovieRealm: Object, MovieProtocol{
    
    @Persisted var adult: Bool
    @Persisted var backdropPath: String?
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var originalTitle: String
    @Persisted var overview: String
    @Persisted var posterPath: String?
    @Persisted var popularity: Double
    //@Persisted var releaseDate: String?
    @Persisted var video: Bool
    @Persisted var voteAverage: Double
    @Persisted var voteCount: Int
}
