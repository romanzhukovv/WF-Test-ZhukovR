//
//  FavoritePhotoViewCell.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 09.06.2022.
//

import UIKit

class FavoritePhotoViewCell: UITableViewCell {
    static let reuseId = "FavoritePhotoCell"

    private let nameLabel = UILabel()
    private let photoImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritePhotoViewCell {
    func configureCell(photo: Photo) {
        guard let url = URL(string: photo.urls?.small ?? "") else { return }
        photoImageView.kf.setImage(with: url)

        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 20
        photoImageView.layer.masksToBounds = true

        nameLabel.text = photo.user?.name
        nameLabel.numberOfLines = 0

        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)

        addConstraits()
    }

    private func addConstraits() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
