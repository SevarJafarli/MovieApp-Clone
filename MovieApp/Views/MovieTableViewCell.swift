//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 10.12.23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieTitleLabel)
            
        applyConstraints()
    }
    
    private func applyConstraints() {
        let posterImageCostraints = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            posterImageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        let movieTitleCostraints = [
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
           
        ]
        NSLayoutConstraint.activate(posterImageCostraints)
        NSLayoutConstraint.activate(movieTitleCostraints)
    }
    
    //MARK: Configure
    public func configure(with model: MovieViewModel) {
       
        guard let url = Constants.imageURL(imagePath: model.posterPath) else { return }
        
        posterImageView.sd_setImage(with: url)
        movieTitleLabel.text = model.movieTitle
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

}
