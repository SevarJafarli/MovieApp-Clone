//
//  SearchResultsViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 03.01.24.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    public var movies: [Movie] = []
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 8, height: 160)
        
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
    public func configure(with movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.searchResultsCollectionView.reloadData()
        }
    }
}
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        
        
        cell.configure(with: movie.poster_path ?? "")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)

        
        // Get the presenting view controller (usually the one that contains the UISearchController)
                if let presentingViewController = presentingViewController as? SearchViewController {
                    // Access the navigation controller if it exists
                    if let navigationController = presentingViewController.navigationController {
                        // Perform navigation to the new view controller
                        let destinationViewController = MovieDetailViewController() // Instantiate your destination view controller
                        let movie = movies[indexPath.row]
                        let viewModel = MovieViewModel(movie: movie)
                        
                        destinationViewController.configure(with: viewModel)
                        navigationController.pushViewController(destinationViewController, animated: true)
                    }
                }
    }
}

