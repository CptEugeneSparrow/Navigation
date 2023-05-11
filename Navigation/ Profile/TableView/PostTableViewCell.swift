//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by new owner on 24.02.2023.
//

import UIKit
import StorageService

final class PostTableViewCell: UITableViewCell {

    var handler: ((IndexPath) -> Void)?

    var indexPath: IndexPath?

    var viewsCount: Int? {
        didSet {
            viewsLabel.text = "Views: \(viewsCount ?? 0 )"
        }
    }

    var isLiked: Bool = false {
        didSet {
            isLiked ? notLiked() : liked()
            isLiked ? (likesCount = 1) : (likesCount = 0)
        }
    }

    var likesCount: Int = 0 {
        didSet {
            likesLabel.text = "Likes: \(likesCount)"
        }
    }

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
        description.numberOfLines = 15
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    private lazy var likesLabel: UILabel = {
        let likes = UILabel()
        likes.numberOfLines = 1
        likes.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        likes.textColor = .systemBlue
        likes.text = "Likes: \(likesCount)"
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()

    private let heartImage: UIImageView = {
        let heartImage = UIImageView(image: UIImage(systemName: "suit.heart.fill"))
        heartImage.tintColor = .systemGray
        heartImage.contentMode = .scaleAspectFit
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        return heartImage
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
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Post, indexPath: IndexPath) {
        self.indexPath = indexPath
        
        authorLabel.text = model.author
        imagePost.image = UIImage(named: model.image)
        descriptionLabel.text = model.description
    }

    private func setupGesture() {
        likesLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likesLabelTapAction))
        likesLabel.addGestureRecognizer(tapGesture)

        let heartTapGesture = UITapGestureRecognizer(target: self, action: #selector(likesLabelTapAction))
        heartImage.addGestureRecognizer(heartTapGesture)
        heartImage.isUserInteractionEnabled = true
    }

    @objc private func likesLabelTapAction() {
        if let indexPath = indexPath {
            handler?(indexPath)
        }
    }

    private func liked() {
        UIView.animate(withDuration: 0.2) {
            self.heartImage.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.heartImage.transform = .identity
        }
        heartImage.tintColor = .systemGray
    }

    private func notLiked() {
        UIView.animate(withDuration: 0.2) {
            self.heartImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.heartImage.transform = .identity
            }
        }
        heartImage.tintColor = .systemPink
    }

    private func layout() {
        [imagePost,
         authorLabel,
         descriptionLabel,
         likesLabel,
         heartImage,
         viewsLabel].forEach { contentView.addSubview( $0 ) }
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

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),

            heartImage.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
            heartImage.leadingAnchor.constraint(equalTo: likesLabel.leadingAnchor, constant: -22),
            heartImage.widthAnchor.constraint(equalToConstant: 20),
            heartImage.heightAnchor.constraint(equalToConstant: 20),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
}


