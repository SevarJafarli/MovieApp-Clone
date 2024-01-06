//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 04.12.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Movie?
    
    private var heroHeaderView: HeroHeaderView?
    
    let sectionTitles: [String] = [
        "Trending Movies",
        "Trending TV",
        "Popular",
        "Upcoming Movies",
        "Top Rated"
    ]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemRed
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        heroHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        heroHeaderView?.delegate = self
        homeFeedTable.tableHeaderView = heroHeaderView
        configureNavBar()
        configureHeroHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getNowPlayingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.randomTrendingMovie = movies.randomElement()
                
                guard let randomTrendingMovie = self?.randomTrendingMovie else {
                    return
                }
              
                let viewModel = MovieViewModel(movie: randomTrendingMovie)
                self?.heroHeaderView?.configure(with: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func configureNavBar() {
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: #selector(tapToLogout))
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func tapToLogout() {
        AuthManager.shared.logout()
            DispatchQueue.main.async {
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.switchToLoginScreen()
                    }
            }
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTVs.rawValue:
            APICaller.shared.getTrendingTVs { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //disable static navbar when scrolling down
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let defaultOffset = view.safeAreaInsets.top
//        let offset = scrollView.contentOffset.y + defaultOffset
//        
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
//    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func didSelectMovie(_ cell: CollectionViewTableViewCell, viewModel: MovieViewModel) {
        let vc = MovieDetailViewController()
        vc.configure(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HeroHeaderViewDelegate {
    func onTapped() {
        guard let randomTrendingMovie = randomTrendingMovie else {
            return
        }
        let viewModel = MovieViewModel(movie: randomTrendingMovie)
        
        let vc = MovieDetailViewController()
        vc.configure(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
