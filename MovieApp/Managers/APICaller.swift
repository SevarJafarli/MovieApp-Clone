//
//  APICaller.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 10.12.23.
//

import Foundation

struct Constants {
    static fileprivate let apiKey = "bbdb36b2746f5cc0eae6bc16c9aa22b4"
    static fileprivate let apiAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmRiMzZiMjc0NmY1Y2MwZWFlNmJjMTZjOWFhMjJiNCIsInN1YiI6IjY1NzU5MTY3NTY0ZWM3MDEzOGJjMWVkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-LiHspMnT6vptcrB7qjbo_Pr5KnmNbSorfzU77C20o8"
    
    static let baseURL = "https://api.themoviedb.org"
    static let apiVersion = "3"
    static func imageURL(imagePath: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(imagePath)")
    }
}



class APICaller {
    static let shared = APICaller()
    
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(Constants.apiAccessToken)"
    ]
    
    public func authenticate(completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = "/authentication"
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) { (result: Result<AuthResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let urlString = "/trending/movie/day?language=en-US"
        
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    public func getTrendingTVs(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "/trending/tv/day?language=en-US"
        
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "/movie/upcoming?language=en-US&page=1"
       
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "/movie/popular?language=en-US&page=1"
       
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "/movie/top_rated?language=en-US&page=1"
       
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
        
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) {(result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "/movie/now_playing?language=en-US&page=1"
        
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) {(result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
   
    
    public func searchMovie(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let urlString = "/search/movie?query=\(query)&include_adult=false&language=en-US&page=1"
        
        URLSession.shared.fetchData(for: urlString, headers: headers, httpMethod: .GET) {(result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

