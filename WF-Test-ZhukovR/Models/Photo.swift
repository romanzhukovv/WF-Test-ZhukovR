//
//  Image.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 06.06.2022.
//

import RealmSwift

class Photo: Object, Codable {
    @Persisted var created_at = ""
    @Persisted var likes = 0
    @Persisted var urls : Sizes?
    @Persisted var user: User?
    @Persisted var downloads = 0
}

class Sizes: Object, Codable {
    @Persisted var small = ""
    @Persisted var full = ""
}

class User: Object, Codable {
    @Persisted var name = ""
    @Persisted var location: String?
}
