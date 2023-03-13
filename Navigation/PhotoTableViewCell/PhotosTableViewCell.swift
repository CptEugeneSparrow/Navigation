//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by new owner on 04.03.2023.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {

    let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var arrowButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()

    var galleryButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let imageViewOne: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kent")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let imageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "boticelli")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let imageViewThree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "renoir")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let imageViewFour: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kandincky")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupLayoutConstraints() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(arrowButton)
        contentView.addSubview(galleryButton)
        contentView.addSubview(imageViewOne)
        contentView.addSubview(imageViewTwo)
        contentView.addSubview(imageViewThree)
        contentView.addSubview(imageViewFour)


        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.inset),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            photosLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),

            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),

            galleryButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galleryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageViewOne.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Metric.inset),
            imageViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            imageViewOne.widthAnchor.constraint(equalToConstant: Metric.imageWidth),
            imageViewOne.heightAnchor.constraint(equalToConstant: Metric.imageHeight),
            imageViewOne.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),

            imageViewTwo.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Metric.inset),
            imageViewTwo.leadingAnchor.constraint(equalTo: imageViewOne.trailingAnchor, constant: Metric.insetImage),
            imageViewTwo.widthAnchor.constraint(equalToConstant: Metric.imageWidth),
            imageViewTwo.heightAnchor.constraint(equalToConstant: Metric.imageHeight),
            imageViewTwo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),

            imageViewThree.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Metric.inset),
            imageViewThree.leadingAnchor.constraint(equalTo: imageViewTwo.trailingAnchor, constant: Metric.insetImage),
            imageViewThree.widthAnchor.constraint(equalToConstant: Metric.imageWidth),
            imageViewThree.heightAnchor.constraint(equalToConstant: Metric.imageHeight),
            imageViewThree.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),

            imageViewFour.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Metric.inset),
            imageViewFour.leadingAnchor.constraint(equalTo: imageViewThree.trailingAnchor, constant: Metric.insetImage),
            imageViewFour.widthAnchor.constraint(equalToConstant: Metric.imageWidth),
            imageViewFour.heightAnchor.constraint(equalToConstant: Metric.imageHeight),
            imageViewFour.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset)
        ])
    }
}

extension PhotosTableViewCell {

    enum Metric {

        static let inset: CGFloat = 13
        static let insetImage: CGFloat = 8
        static let screenWidth = UIScreen.main.bounds.width
        static let imageWidth = (screenWidth - 48) / 4
        static let imageHeight = imageWidth / 4 * 3
    }
}

