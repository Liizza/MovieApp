//
//  User.swift
//  MovieApp
//
//  Created by user222465 on 12/11/22.
//

import UIKit

class User {
    static let shared = User()
    var accountId: Int?
    var sessionId: String?
    private init() {
    }
}
