//
//  ProfileViewController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit
import StorageService

final class ProfileViewController: UIViewController {

    var likesDict: [IndexPath: Bool] = [:]

    private let likesKey = "likesKey"
    var isIncreaceOfViews = false

    private lazy var likesHandler = { [weak self] (indexPath: IndexPath) in
        guard let self = self else { return }
        let cell = self.postTableView.cellForRow(at: indexPath) as! PostTableViewCell

        if !cell.isLiked {
            cell.isLiked = true
            self.likesDict[indexPath] = true
        } else {
            cell.isLiked = false
            self.likesDict[indexPath] = false
        }
        let data = try? JSONEncoder().encode(self.likesDict)
        UserDefaults.standard.set(data, forKey: self.likesKey)
    }
    
    public var postModel: [[Any]] = [["Photos"], Post.makePost()]
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.sectionHeaderTopPadding = .zero
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray4
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func loadView() {
        super.loadView()
//#if DEBUG
//return view.backgroundColor = .systemBlue
//#else
//return view.backgroundColor = .systemGreen
//#endif
        view = Configuration.viewForDebugOrRelease
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func layout() {
        view.addSubview(postTableView)
        
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return postModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postModel[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            cell.galleryButton.addTarget(self, action: #selector(galleryButtonAction), for: .touchUpInside)
            return cell

        default:
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell

            if let model: Post = postModel[indexPath.section][indexPath.row] as? Post {
                cell.setupCell(model: model, indexPath: indexPath)
                cell.handler = likesHandler
                cell.viewsCount = UserDefaults.standard.integer(forKey: "post_\(indexPath.section)_\(indexPath.row)_viewsCount")

                let data = UserDefaults.standard.data(forKey: self.likesKey) ?? Data()
                let encodedDict = try? JSONDecoder().decode([IndexPath: Bool].self, from: data)

                if let encodedDict = encodedDict {
                    if let isLiked = encodedDict[indexPath] {
                        cell.isLiked = isLiked
                    }
                }

                return cell
            } else {
                return UITableViewCell()
            }
        }
    }

    @objc
    private func galleryButtonAction() {
        let photosVC = PhotosViewController()
        navigationController?.pushViewController(photosVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? ProfileTableHeaderView() : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return indexPath.section == 1
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if indexPath.section == 1 && editingStyle == .delete {
                postModel[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = postModel[indexPath.section][indexPath.row] as? Post else {
            return
        }
        let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell

        let detailVС = DetailDescriptionPostViewController(post: post) { count in
            cell.viewsCount! += count

            UserDefaults.standard.set(cell.viewsCount!, forKey: "post_\(indexPath.section)_\(indexPath.row)_viewsCount")
        }
        present(detailVС, animated: true)
    }
}
