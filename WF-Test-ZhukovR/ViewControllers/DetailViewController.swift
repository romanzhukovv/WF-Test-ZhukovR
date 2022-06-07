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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchFullSizePhoto(photo: photo ?? Photo(likes: 0, urls: Sizes(small: "", full: ""), user: User(name: "")))
        
        photoImageView.contentMode = .scaleAspectFit
        
        favoriteButton.setTitle("Add to favorite", for: .normal)
        favoriteButton.setTitleColor(.white, for: .normal)
        favoriteButton.backgroundColor = .lightGray
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        favoriteButton.layer.cornerRadius = 10
        
        view.addSubview(photoImageView)
        view.addSubview(favoriteButton)
        
        addConstraints()
    }

}

extension DetailViewController {
    private func addConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            
            favoriteButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 100),
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
