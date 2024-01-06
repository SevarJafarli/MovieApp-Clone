//
//  Movie.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 10.12.23.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String?
    let original_title: String?
    let overview: String?
    let media_type: String?
    let release_date: String?
    let poster_path: String?
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
}
