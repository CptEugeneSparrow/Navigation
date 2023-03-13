//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by new owner on 24.02.2023.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    private let imagePost: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let authorLabel: UILabel = {
        let author = UILabel()
        author.textColor = .darkGray
        author.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        author.numberOfLines = 0
        author.translatesAutoresizingMaskIntoConstraints = false
        return author
    }()

    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        description.textColor = .darkGray
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    private let likesLabel: UILabel = {
        let likes = UILabel()
        likes.numberOfLines = 1
        likes.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        likes.textColor = .darkGray
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()

    private let viewsLabel: UILabel = {
        let views = UILabel()
        views.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        views.textColor = .darkGray
        views.numberOfLines = 1
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Post) {
        authorLabel.text = model.author
        imagePost.image = UIImage(named: model.image)
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
    }

    private func layout() {
        [imagePost, authorLabel, descriptionLabel, likesLabel,viewsLabel].forEach { contentView.addSubview( $0 ) }
        contentView.backgroundColor = .systemGray5
        contentView.layer.borderWidth = 0
        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),


            imagePost.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            imagePost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -0.5),
            imagePost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.5),
            imagePost.heightAnchor.constraint(equalToConstant: 300),


            descriptionLabel.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),


            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),


            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
}
