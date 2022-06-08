//
//  StorageManager.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 08.06.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func savePhoto(photo: Photo) {
        try! realm.write {
            realm.add(photo)
        }
    }
}
