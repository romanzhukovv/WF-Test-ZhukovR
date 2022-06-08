//
//  NetworkManager.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 06.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkManager {
    static let shared = NetworkManager()
    
    private let url = "https://api.unsplash.com/photos/random?&count=30&client_id=j0jvFBCxGG342dl2oyuw497E6Eh7eMvCOQz8gu-U5Ow"
    
    private init() {}
    
    func fetchData(completion: @escaping(Result<[Photo], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let images = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(images))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func searchPhotos(url: String, completion: @escaping(Result<SearchedPhotos, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let images = try JSONDecoder().decode(SearchedPhotos.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(images))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
