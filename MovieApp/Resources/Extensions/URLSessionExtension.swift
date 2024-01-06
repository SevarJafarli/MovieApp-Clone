//
//  URLSessionExtension.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 10.12.23.
//

import Foundation


extension URLSession {
    func fetchData<T: Codable>(for url: String, headers: [String: String], httpMethod: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
        let request = NSMutableURLRequest(url:  URL(string: "\(Constants.baseURL)/\(Constants.apiVersion)\(url)")!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        self.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "error")
                completion(.failure(error ?? APIError.failedToGetData))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
                
            }
            catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
