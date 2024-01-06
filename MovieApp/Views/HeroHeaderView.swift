//
//  HeroHeaderView.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 09.12.23.
//

import UIKit
protocol HeroHeaderViewDelegate: AnyObject {
    func onTapped()
}
class HeroHeaderView: UIView {
    weak var delegate: HeroHeaderViewDelegate?
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    
        return imageView
    }()
    
    
    private let playButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.setTitle("Play", for: .normal)
        return button
    }()
    private let downloadButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.setTitle("Download", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(heroImageView)
        addGradient()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        
        self.addGestureRecognizer(tapGesture)
        
        // Enable user interaction for the UIView
        self.isUserInteractionEnabled = true
//        addSubview(playButton)
//        addSubview(downloadButton)
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
       
    }
    @objc private func onTapped() {
        delegate?.onTapped()
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.gray.cgColor
        ]
        layer.frame = bounds
        
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ]
//        NSLayoutConstraint.activate(playButtonConstraints)
//        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: MovieViewModel) {
        guard let url = Constants.imageURL(imagePath: model.posterPath) else { return }
        
        heroImageView.sd_setImage(with: url)
    }
    
        
      
      
     

}
