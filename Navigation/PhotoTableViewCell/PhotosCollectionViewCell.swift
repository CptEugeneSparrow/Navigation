//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by new owner on 04.03.2023.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {

    var collectionImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupLayoutConstraints() {
        contentView.addSubview(collectionImageView)

        NSLayoutConstraint.activate ([
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
