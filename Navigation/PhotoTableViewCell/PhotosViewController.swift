//
//  PhotosViewController.swift
//  Navigation
//
//  Created by new owner on 04.03.2023.
//

import UIKit

final class PhotosViewController: UIViewController {

    private let photoGallery: [ImageGallery] = PhotoGallery.photos(with: 24)

    private var selectedCell: UICollectionViewCell? = nil

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let translucentView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.tintColor = .white
        button.addTarget(self, action: #selector(hideSelectedImage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white
        setupNavigationBar()
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Gallery"
        navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
        navigationController?.toolbar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.collectionImageView.image = UIImage(named: photoGallery[indexPath.item].imageName)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    private var sideInset: CGFloat { return 8 }
    private var elementCount: CGFloat { return 3}
    private var insetsCount: CGFloat { return elementCount + 1}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (collectionView.bounds.width - sideInset * insetsCount) / elementCount
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: .zero, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}

extension PhotosViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = UIImage(named: photoGallery[indexPath.row].imageName) {
            selectedCell = collectionView.cellForItem(at: indexPath)
            showSelectedImage(image: image)
        }
    }
}

extension PhotosViewController {

    private func showSelectedImage(image: UIImage) {
        guard let cell = selectedCell else { return }
        view.addSubview(translucentView)
        view.bringSubviewToFront(translucentView)

        translucentView.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: translucentView.safeAreaLayoutGuide.topAnchor, constant: 56).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: translucentView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true

        let imageView: UIImageView = {
            let imageView = UIImageView(frame: cell.bounds)
            imageView.image = image
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideSelectedImage)))
            return imageView
        }()
        translucentView.addSubview(imageView)
        imageView.center = cell.center
        let scaleOfSize = translucentView.bounds.width / imageView.bounds.width
        imageView.alpha = 0
        translucentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        translucentView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            imageView.alpha = 1
            self.translucentView.alpha = 1
            imageView.transform = CGAffineTransform(scaleX: scaleOfSize, y: scaleOfSize)
            imageView.center = self.translucentView.center
        }, completion: {_ in
            UIView.animate(withDuration: 0.4) {
                self.closeButton.alpha = 1
            }
        })
    }

    @objc private func hideSelectedImage() {
        guard let cell = selectedCell,
              let imageView = translucentView.subviews.first(where: { $0 is UIImageView })
        else { return }

        let scaleOfSize = cell.bounds.width/imageView.bounds.width
        let originalCenter = translucentView.convert(cell.center, from: cell.superview)

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.translucentView.backgroundColor = .black.withAlphaComponent(0)
            imageView.transform = CGAffineTransform(scaleX: scaleOfSize, y: scaleOfSize)
            imageView.center = originalCenter
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 0
            }
            self.translucentView.removeFromSuperview()
            self.translucentView.subviews.forEach({ $0.removeFromSuperview() })
        })
    }
}

