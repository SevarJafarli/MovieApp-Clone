//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 10.12.23.
//

import Foundation

struct MovieViewModel {
    let id: Int
    let movieTitle: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double?
    
    
    init(movie: Movie) {
        self.id = movie.id  
        self.movieTitle = movie.title ?? movie.original_title ?? "Unknown"
        self.overview = movie.overview ?? ""
        self.voteAverage = movie.vote_average
        self.releaseDate = "Released at \(movie.release_date ?? "")"
        self.posterPath = movie.poster_path ?? ""
      
    }
    
    init(id: Int, movieTitle: String, posterPath: String, overview: String, releaseDate: String, voteAverage: Double?) {
        self.id = id
        self.movieTitle = movieTitle
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}
