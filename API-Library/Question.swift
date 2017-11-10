//
//  congrats.swift
//  API-Library
//
//  Created by Centra Tech on 11/10/17.
//  Copyright © 2017 API-Library. All rights reserved.
//

import Foundation

struct Question {
    let title: String
    let score: Int
    let tags: [String]
    let date: Date
    let owner: User?
}
