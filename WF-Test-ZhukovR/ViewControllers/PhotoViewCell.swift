//
//  PhotoViewCell.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    private let photoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}

extension PhotoViewCell {
    func configureCell(photo: Photo) {
        NetworkManager.shared.fetchImage(from: photo.urls.small) { result in
            switch result {
            case .success(let photo):
                self.photoImageView.image = UIImage(data: photo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}
