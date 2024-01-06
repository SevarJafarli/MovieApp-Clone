//
//  AuthManager.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 06.01.24.
//

import UIKit

class AuthManager {
    static let shared = AuthManager()
  
    func login() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")

    }
    func logout () {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        
    }
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
