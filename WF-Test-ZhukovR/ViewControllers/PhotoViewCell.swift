//
//  PhotoViewCell.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit
import Kingfisher

class PhotoViewCell: UICollectionViewCell {
    static let reuseId = "PhotoCell"
    
    private let photoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        guard let url = URL(string: photo.urls?.small ?? "") else { return }
        photoImageView.kf.setImage(with: url)
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        addConstraints()
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
