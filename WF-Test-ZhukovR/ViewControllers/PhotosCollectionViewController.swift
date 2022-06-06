//
//  PhotosCollectionViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

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
        collectionView!.register(PhotoViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupSearchController()
        fetchPhotosData()
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return searchedPhotos?.results?.count ?? 0
        }
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoViewCell
        var photo = Photo(likes: 0, urls: Sizes(small: "", full: ""), user: User(name: ""))
        
        if isSearching {
            photo = searchedPhotos?.results?[indexPath.row] ?? Photo(likes: 0, urls: Sizes(small: "", full: ""), user: User(name: ""))
        } else {
            photo = photos[indexPath.row]
        }
        
        cell.configureCell(photo: photo)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
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

extension PhotosCollectionViewController: UISearchResultsUpdating {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search photo"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        searchPhotosData(query: searchController.searchBar.text ?? "")
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
                if query.count > 0 {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
