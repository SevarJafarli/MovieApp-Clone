//
//  UpcomingViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 04.12.23.
//

import UIKit

class UpcomingViewController: UIViewController {
    private var movies: [Movie] = []
    private let upcomingMovieTable: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        tableView.register(MovieTableViewCell.self  , forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .systemRed
        view.addSubview(upcomingMovieTable)
        upcomingMovieTable.delegate = self
        upcomingMovieTable.dataSource = self
        fetchUpcomingMovies()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingMovieTable.frame = view.bounds
    }
    
    private func fetchUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.upcomingMovieTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: UITableView
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
       
        let viewModel = MovieViewModel(movie: movie)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = MovieDetailViewController()
        let movie = movies[indexPath.row]
       
        
        let viewModel = MovieViewModel(movie: movie)
        
        vc.configure(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
