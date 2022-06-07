//
//  StorageManager.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 08.06.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private init() {
        
    }
    
    func savePhotoToFavorite(photo: Photo) {
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(photo), forKey: photo.)
        UserDefaults.standard.dictionaryRepresentation().values
    }
}
