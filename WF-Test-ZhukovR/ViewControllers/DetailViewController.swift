//
//  ViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: Photo?
    
    private let photoImageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)
    private let authorNameLabel = UILabel()
    private let createdDateLabel = UILabel()
    private let locationLabel = UILabel()
    private let downloadsCountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchFullSizePhoto(photo: photo ?? Photo(created_at: "", likes: 0, urls: Sizes(small: "", full: ""), user: User(name: "", location: ""), downloads: 0))
        
        photoImageView.contentMode = .scaleAspectFit
        
        authorNameLabel.text = photo?.user.name
        authorNameLabel.textAlignment = .center
        
        createdDateLabel.text = photo?.created_at
        createdDateLabel.textAlignment = .center
        
        locationLabel.text = photo?.user.location ?? "No location data"
        locationLabel.textAlignment = .center
        
        downloadsCountLabel.text = "\(photo?.downloads ?? 0)"
        downloadsCountLabel.textAlignment = .center
        
        favoriteButton.setTitle("Add to favorite", for: .normal)
        favoriteButton.setTitleColor(.white, for: .normal)
        favoriteButton.backgroundColor = .lightGray
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        favoriteButton.layer.cornerRadius = 10
        
        view.addSubview(photoImageView)
        view.addSubview(authorNameLabel)
        view.addSubview(createdDateLabel)
        view.addSubview(locationLabel)
        view.addSubview(downloadsCountLabel)
        view.addSubview(favoriteButton)
        
        addConstraints()
    }

}

extension DetailViewController {
    private func addConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            
            authorNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15),
            authorNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            createdDateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 15),
            createdDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createdDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 15),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            downloadsCountLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            downloadsCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadsCountLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: downloadsCountLabel.bottomAnchor, constant: 15),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func fetchFullSizePhoto(photo: Photo) {
        NetworkManager.shared.fetchImage(from: photo.urls.full) { result in
            switch result {
            case .success(let photo):
                self.photoImageView.image = UIImage(data: photo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func favoriteButtonAction() {
        print("tap")
    }
}
