//
//  SearchedPhoto.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 06.06.2022.
//

import RealmSwift

class SearchedPhotos: Object, Codable {
    @Persisted var results = List<Photo>()
}
