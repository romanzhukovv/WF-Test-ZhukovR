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
    private let verticalStackView = UIStackView()
    private let authorNameLabel = UILabel()
    private let createdDateLabel = UILabel()
    private let locationLabel = UILabel()
    private let downloadsCountLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchFullSizePhoto(photo: photo ?? Photo(created_at: "", likes: 0, urls: Sizes(small: "", full: ""), user: User(name: "", location: ""), downloads: 0))
        
        setupUIComponets()
    }

}

extension DetailViewController {
    private func addConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            
            verticalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: downloadsCountLabel.bottomAnchor, constant: 15),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupUIComponets() {
        photoImageView.contentMode = .scaleAspectFit
        
        authorNameLabel.text = photo?.user.name
        authorNameLabel.textAlignment = .center
        
        createdDateLabel.text = photo?.created_at
        createdDateLabel.textAlignment = .center
        
        locationLabel.text = photo?.user.location ?? "No location data"
        locationLabel.textAlignment = .center
        
        downloadsCountLabel.text = "\(photo?.downloads ?? 0)"
        downloadsCountLabel.textAlignment = .center
        
        verticalStackView.spacing = 15
        verticalStackView.axis = .vertical
        
        favoriteButton.setTitle("Add to favorite", for: .normal)
        favoriteButton.setTitleColor(.white, for: .normal)
        favoriteButton.backgroundColor = .lightGray
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        favoriteButton.layer.cornerRadius = 10
        
        view.addSubview(photoImageView)
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(authorNameLabel)
        verticalStackView.addArrangedSubview(createdDateLabel)
        verticalStackView.addArrangedSubview(locationLabel)
        verticalStackView.addArrangedSubview(downloadsCountLabel)
        view.addSubview(favoriteButton)
        
        addConstraints()
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
        showAlert()
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Saving", message: "Photo was saved to favorite list", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
