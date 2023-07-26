//
//  AuthenticationError.swift
//  MovieApp
//
//  Created by Liza on 11.04.2023.
//

import Foundation

enum AuthenticationError: String, Error {
    case noInternetConnection = "The Internet connection appears to be offline"
    case invalidUserData = "Invalid username and/or password"
    case anyError = "Something went wrong"
}
