//
//  Image.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 06.06.2022.
//

import Foundation

struct Photo: Codable {
    let created_at: String?
    let likes: Int
    let urls : Sizes
    let user: User
    let downloads: Int?
}

struct Sizes: Codable {
    let small: String
    let full: String
}

struct User: Codable {
    let name: String
    let location: String?
}
