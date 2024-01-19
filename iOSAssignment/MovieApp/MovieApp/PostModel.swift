//
//  PostModel.swift
//  MovieApp
//
//  Created by Jatin Kamal Vangani on 19/01/24.
//

import Foundation
struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
