//
//  LoginModels.swift
//  MovieApp
//
//  Created by user222465 on 10/4/22.
//

import Foundation

struct TokenResponse: Codable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

struct TokenRequest: Codable {
    let requestToken: String
    enum CodingKeys:String,CodingKey{
        case requestToken = "request_token"
    }
}

struct LoginValidation: Codable {
    let username, password, requestToken: String

    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}


struct SessionResponse: Codable {
    let success: Bool
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}

struct AccountDetailsResponse: Codable {
    let avatar: Avatar
    let id: Int
    let iso639_1, iso3166_1, name: String
    let includeAdult: Bool
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

struct Gravatar: Codable {
    let hash: String
}

struct Tmdb: Codable {
    let avatarPath: JSONNull?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
        return
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


struct DeleteSessionRequest:Codable{
    let sessionId:String
    
    enum CodingKeys:String,CodingKey {
        case sessionId = "session_id"
    }
}

struct DeleteSessionResponse:Codable {
    let success:Bool
}


