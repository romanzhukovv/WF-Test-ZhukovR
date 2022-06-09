//
//  ViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    private let photo: Photo
    
    private let activityIndicator = UIActivityIndicatorView()
    private let photoImageView = UIImageView()
    private let verticalStackView = UIStackView()
    private let authorNameLabel = UILabel()
    private let createdDateLabel = UILabel()
    private let locationLabel = UILabel()
    private let downloadsCountLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
    }
}

extension DetailViewController {
    private func addConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.45),
            
            verticalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: downloadsCountLabel.bottomAnchor, constant: 15),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        photoImageView.contentMode = .scaleAspectFit
        fetchFullSizePhoto(photo: photo)
        
        authorNameLabel.text = photo.user?.name
        authorNameLabel.textAlignment = .center
        
        createdDateLabel.text = photo.created_at
        createdDateLabel.textAlignment = .center
        
        locationLabel.text = photo.user?.location ?? "No location data"
        locationLabel.textAlignment = .center
        
        downloadsCountLabel.text = "\(photo.downloads ?? 0)"
        downloadsCountLabel.textAlignment = .center
        
        verticalStackView.spacing = 15
        verticalStackView.axis = .vertical
        
        favoriteButton.setTitle(photo.isFavorite ?? false ? "Delete from favorite" : "Save to favorite", for: .normal)
        favoriteButton.setTitleColor(.white, for: .normal)
        favoriteButton.backgroundColor = photo.isFavorite ?? false ? .systemRed : .systemBlue
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        favoriteButton.layer.cornerRadius = 10
        
        view.addSubview(activityIndicator)
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
        guard let url = URL(string: photo.urls?.full ?? "") else { return }
        
        photoImageView.kf.setImage(with: url) { _ in
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc private func favoriteButtonAction() {
        showAlert(isFavorite: photo.isFavorite ?? false)
    }
    
    private func showAlert(isFavorite: Bool) {
        let alertController = UIAlertController(title: isFavorite ? "Deleting" : "Saving",
                                                message: isFavorite ? "Photo was deleted from favorite list" : "Photo was saved to favorite list" ,
                                                preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if isFavorite {
                StorageManager.shared.deletePhoto(photo: self.photo)
                self.navigationController?.popViewController(animated: true)
            } else {
                StorageManager.shared.savePhoto(photo: self.photo)
                StorageManager.shared.photoDidFavorite(photo: self.photo)
                
                self.favoriteButton.setTitle(self.photo.isFavorite ?? false ? "Delete from favorite" : "Save to favorite", for: .normal)
                self.favoriteButton.backgroundColor = self.photo.isFavorite ?? false ? .systemRed : .systemBlue
            }
        }
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
