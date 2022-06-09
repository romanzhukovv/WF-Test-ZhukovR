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
        write {
            realm.add(photo)
        }
    }
    
    func deletePhoto(photo: Photo) {
        write {
            realm.delete(photo)
        }
    }
    
    func photoDidFavorite(photo: Photo) {
        write {
            photo.setValue(true, forKey: "isFavorite")
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
