//
//  Model.swift
//  MovieApp
//
//  Created by Jatin Kamal Vangani on 19/01/24.
//

import Foundation
struct Object: Codable {
    let search: [Details]?
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
struct Details: Codable {
    let title: String
    let year: String
    let type: String
    let poster: String
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
