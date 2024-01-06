//
//  VoteRateView.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 05.01.24.
//

import UIKit

class VoteRateView: UIView {
    
    public func configure(with voteRate: Double) {
        numberLabel.text = "\(round(10 * voteRate) / 10)"
    }
    private var numberLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupContainer() {
        // Set the container's width and height
        
        backgroundColor = .label.withAlphaComponent(0.3)
        layer.cornerRadius = 6
        layer.masksToBounds = true
        // Create the star icon UIImageView
        var image =  UIImage(systemName: "star.fill")
        image = image?.withRenderingMode(.alwaysTemplate)
        let starImageView = UIImageView(image: image)
        starImageView.contentMode = .scaleAspectFit
        
        starImageView.tintColor = .systemYellow
        starImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15) // Adjust the frame as needed
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        // Create the label for "9"
        numberLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 30, height: 15)) // Adjust the frame as needed
        numberLabel.text = "9"
        numberLabel.textAlignment = .center
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        // Add the star icon and label to the container
        //horizontal stack
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.spacing = 2
        hStack.alignment = .center
        
        hStack.addArrangedSubview(starImageView)
        hStack.addArrangedSubview(numberLabel)
        self.addSubview(hStack)
        
        NSLayoutConstraint.activate(
            [
                
                hStack.topAnchor.constraint(equalTo: topAnchor, constant: 4),
                hStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
                hStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
                hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            ]
            
        )
    }
}
