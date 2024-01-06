//
//  DownloadsViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 04.12.23.
//

import UIKit

class DownloadsViewController: UIViewController {
    private var savedMovies: [SavedMovie] = []
    
    private let savedMoviesTable: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .systemRed
        view.addSubview(savedMoviesTable)
        savedMoviesTable.delegate = self
        savedMoviesTable.dataSource = self
        fetchSavedMovies()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedMoviesTable.frame = view.bounds
    }
    
    private func fetchSavedMovies() {
        savedMovies =  DataPersistenceManager.shared.getSavedMovies()
        savedMovies.reverse()
        savedMoviesTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchSavedMovies()
    }
}


extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let savedMovie = savedMovies[indexPath.row]
        
        
        let viewModel = MovieViewModel(id: Int(savedMovie.id), movieTitle: savedMovie.movieTitle!, posterPath: savedMovie.posterPath!, overview: savedMovie.overview!, releaseDate: savedMovie.releaseDate!, voteAverage: savedMovie.voteAverage)
        
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = MovieDetailViewController()
        let savedMovie = savedMovies[indexPath.row]
        
        
        let viewModel = MovieViewModel(id: Int(savedMovie.id), movieTitle: savedMovie.movieTitle!, posterPath: savedMovie.posterPath!, overview: savedMovie.overview!, releaseDate: savedMovie.releaseDate!, voteAverage: savedMovie.voteAverage)
        
        
        vc.configure(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let savedMovie = savedMovies[indexPath.row]
            let viewModel = MovieViewModel(id: Int(savedMovie.id), movieTitle: savedMovie.movieTitle!, posterPath: savedMovie.posterPath!, overview: savedMovie.overview!, releaseDate: savedMovie.releaseDate!, voteAverage: savedMovie.voteAverage)
            
            DataPersistenceManager.shared.deleteMovie(model: viewModel) { [weak self] result in
                switch result {
                case .success(let isDeleted):
                    self?.fetchSavedMovies()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
