//
//  ViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 04.12.23.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        //        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: DownloadsViewController())
        let vc4 = UINavigationController(rootViewController: AccountViewController())
        
        
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        
        vc2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "bookmark"), tag: 3)
        vc4.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person"), tag: 4)
        tabBar.tintColor = .systemRed
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}

