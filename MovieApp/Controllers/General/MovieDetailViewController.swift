//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 05.01.24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private  let contentView = MovieDetailView()
    
    private var viewModel: MovieViewModel?
    public func configure(with viewModel: MovieViewModel) {
        self.viewModel = viewModel
        contentView.configure(with: viewModel)
    }
    var isMovieInSaveList: Bool = false
    private var saveBtn = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemRed
        guard viewModel != nil else { return }
        isMovieInSaveList =  DataPersistenceManager.shared.isMovieInList(viewModel: viewModel!)
        
        saveBtn = UIBarButtonItem(image: UIImage(systemName: isMovieInSaveList ? "bookmark.fill" : "bookmark"), style: .done, target: self, action: #selector(onSaveBtnTapped))
        navigationItem.rightBarButtonItem = saveBtn
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        
        scrollView.isUserInteractionEnabled = true
        scrollView.frame = view.bounds
        
        scrollView.addSubview(contentView)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
        ])
        
        
    }
    @objc private func onSaveBtnTapped() {
        guard viewModel != nil else {
            return
        }
        if isMovieInSaveList {
            DataPersistenceManager.shared.deleteMovie(model: viewModel!) { result in
                switch result {
                case .success(let isDeleted):
                    self.saveBtn.image =  UIImage(systemName: isDeleted ? "bookmark" : "bookmark.fill")
                    self.isMovieInSaveList = false
                case .failure(let error):
                    print(error)
//                    self.isMovieInSaveList = tr
                }
            }
        }
        else {
            DataPersistenceManager.shared.saveMovie(model: viewModel!) { result in
                switch result {
                case .success(let isSaved):
                    self.saveBtn.image =  UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    self.isMovieInSaveList = true
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

