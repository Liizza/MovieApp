//
//  DataManager.swift
//  MovieApp
//
//  Created by user222465 on 10/25/22.
//

import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    
    let realm = try? Realm()
    private init() {
    }
    func saveMovies(media: MovieTMDB?) {
        guard let realm  else { return }
        let movieRealm = MovieRealm()
        movieRealm.adult = media?.adult ?? false
        movieRealm.backdropPath = media?.backdropPath ?? ""
        movieRealm.id = media?.id ?? 0
        movieRealm.originalTitle = media?.originalTitle ?? ""
        movieRealm.overview = media?.overview ?? ""
        movieRealm.popularity = media?.popularity ?? 0.0
        movieRealm.posterPath = media?.posterPath ?? ""
        movieRealm.title = media?.title ?? ""
        movieRealm.video = media?.video ?? false
        movieRealm.voteAverage = media?.voteAverage ?? 0.0
        movieRealm.voteCount = media?.voteCount ?? 0
        realm.add(movieRealm, update: .all)
    }
    func getListOfMovies() -> [MovieRealm]? {
        guard let realm  else { return nil }
        let results = Array(realm.objects(MovieRealm.self))
        return results
    }
    func deleteMovies(_ completion: @escaping() -> Void) {
        guard let realm  else { return }
        try? realm.write {
            realm.delete((realm.objects(MovieRealm.self)))
            completion()
        }
    }
}
