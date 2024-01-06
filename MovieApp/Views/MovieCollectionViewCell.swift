//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 10.12.23.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK:Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    //MARK: Configure
    public func configure(with model: String) {
        guard let url = Constants.imageURL(imagePath: model) else { return }
        
        posterImageView.sd_setImage(with: url)
    }
}
