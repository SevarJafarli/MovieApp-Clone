//
//  AuthViewController.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 06.01.24.
//

import UIKit

class AuthViewController: UIViewController {
    private let welcomeTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Welcome"
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()
    private let welcomeText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Watch thousands of hit movies and TV series for free"
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        return lbl
    }()
    private let welcomeImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "welcome"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        
        return img
        
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(configuration: .filled())
        btn.tintColor = .systemRed
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.textColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeTitle)
        view.addSubview(welcomeText)
        view.addSubview(welcomeImage)
        view.addSubview(loginBtn)
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            welcomeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            welcomeTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            welcomeImage.topAnchor.constraint(equalTo: welcomeTitle.bottomAnchor, constant: 32),
            welcomeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeImage.widthAnchor.constraint(equalToConstant: 250),
            welcomeImage.heightAnchor.constraint(equalToConstant: 250),
            
            welcomeText.topAnchor.constraint(equalTo: welcomeImage.bottomAnchor, constant: 16),
            welcomeText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            welcomeText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            loginBtn.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 32),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            loginBtn.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    @objc private func tapToLogin() {
        APICaller.shared.authenticate { result in
            switch result {
            case .success(let success):
                if success {
                    AuthManager.shared.login()
                    DispatchQueue.main.async {
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                                sceneDelegate.switchToHomeScreen()
                            }
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
