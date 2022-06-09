//
//  PhotosCollectionViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    private var photos: [Photo] = []
    private var searchedPhotos: SearchedPhotos?
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isSearching: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView!.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.reuseId)
        fetchPhotosData()
        setupSearchController()
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return searchedPhotos?.results.count ?? 0
        }
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseId, for: indexPath) as! PhotoViewCell
        let photo: Photo
        
        if isSearching {
            guard let searchedPhoto = searchedPhotos?.results[indexPath.row] else { return cell }
            photo = searchedPhoto
        } else {
            photo = photos[indexPath.row]
        }
        
        cell.configureCell(photo: photo)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo: Photo
        
        if self.isSearching {
            guard let searchedPhoto = searchedPhotos?.results[indexPath.row] else { return }
            photo = searchedPhoto
        } else {
            photo = photos[indexPath.row]
        }
        
        let detailVC = DetailViewController(photo: photo)
        
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width - 1) / 2, height: (view.frame.width - 1) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}

extension PhotosCollectionViewController: UISearchBarDelegate {
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search photo"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPhotosData(query: searchController.searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if !searchBarIsEmpty && searchedPhotos != nil {
            collectionView.reloadData()
            searchedPhotos = nil
        } else if searchBarIsEmpty && searchedPhotos != nil {
            collectionView.reloadData()
            searchedPhotos = nil
        }
    }
}

extension PhotosCollectionViewController {
    private func fetchPhotosData() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let data):
                self.photos = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func searchPhotosData(query: String) {
        let url = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=j0jvFBCxGG342dl2oyuw497E6Eh7eMvCOQz8gu-U5Ow"
        
        NetworkManager.shared.searchPhotos(url: url) { result in
            switch result {
            case .success(let data):
                self.searchedPhotos = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
