//
//  OtherTMDBModels.swift
//  MovieApp
//
//  Created by Liza on 26.04.2023.
//

import Foundation

struct ListOfGenresResponce: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}


struct PostFavoriteMovieResponse: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
struct PostFavoriteMovieRequest: Codable {
    let mediaType: String
    let mediaID: Int
    let favorite: Bool

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
}

struct GetVideosResponse: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
