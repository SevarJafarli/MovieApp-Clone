//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 05.01.24.
//

import UIKit

class MovieDetailView: UIView {
    public func configure(with viewModel: MovieViewModel) {
        titleLabel.text = viewModel.movieTitle
        overviewLabel.text = viewModel.overview
        releaseDate.text = viewModel.releaseDate
        guard let url = Constants.imageURL(imagePath: viewModel.posterPath) else { return }
        
        guard let voteAverage = viewModel.voteAverage else {
            return
        }
        voteRateView.configure(with: voteAverage)
  
        posterImageView.sd_setImage(with: url)
    }
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    private let aboutLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemRed
        label.text = "About"
        
        return label
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        return imageView
    }()
    
    private let releaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let voteRateView = VoteRateView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(aboutLabel)
        addSubview(overviewLabel)
        addSubview(posterImageView)
        voteRateView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(voteRateView)
        addSubview(releaseDate)
        configureConstraints()
    }
    
    func configureConstraints() {
        let imageConstraints = [posterImageView.topAnchor.constraint(equalTo: topAnchor),
                                posterImageView.heightAnchor.constraint(equalToConstant: 400)
                            ]
        
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            
        ]
        let aboutConstraints = [
            aboutLabel.topAnchor.constraint(equalTo: voteRateView.bottomAnchor, constant: 8),
            aboutLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8)
        ]
        let overviewConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            overviewLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            overviewLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8)
            
        ]
        
        let voteRateViewConstraints = [
            voteRateView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            voteRateView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8)
           
        ]
        
        let releaseDateConstraints = [
            releaseDate.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 8),
            releaseDate.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(voteRateViewConstraints)
        NSLayoutConstraint.activate(aboutConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(releaseDateConstraints)

       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
