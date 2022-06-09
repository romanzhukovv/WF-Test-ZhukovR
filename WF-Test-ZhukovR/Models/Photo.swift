//
//  Image.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 06.06.2022.
//

import RealmSwift

class Photo: Object, Codable {
    @Persisted var isFavorite: Bool?

    @Persisted var created_at: String?
    @Persisted var likes: Int?
    @Persisted var urls : Sizes?
    @Persisted var user: User?
    @Persisted var downloads: Int?
}

class Sizes: Object, Codable {
    @Persisted var small: String?
    @Persisted var full: String?
}

class User: Object, Codable {
    @Persisted var name: String?
    @Persisted var location: String?
}
