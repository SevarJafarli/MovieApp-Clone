//
//  AuthResponse.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 06.01.24.
//

import Foundation


// MARK: - AuthResponse
struct AuthResponse: Codable {
    let success: Bool
    let status_code: Int
    let status_message: String
}
