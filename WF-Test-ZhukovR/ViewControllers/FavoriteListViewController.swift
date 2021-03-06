//
//  FavoriteListViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit
import RealmSwift
import Kingfisher

class FavoriteListViewController: UITableViewController {
    var favoritePhotos: Results<Photo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoritePhotoViewCell.self, forCellReuseIdentifier: FavoritePhotoViewCell.reuseId)
        tableView.backgroundColor = .white
        favoritePhotos = StorageManager.shared.realm.objects(Photo.self)
        tableView.rowHeight = 140
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritePhotos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePhotoViewCell.reuseId, for: indexPath) as! FavoritePhotoViewCell
        let photo = favoritePhotos[indexPath.row]

        cell.configureCell(photo: photo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = favoritePhotos[indexPath.row]
        let detailVC = DetailViewController(photo: photo)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
