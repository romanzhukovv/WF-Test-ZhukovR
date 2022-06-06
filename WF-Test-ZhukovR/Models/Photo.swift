//
//  Image.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 06.06.2022.
//

import Foundation

struct Photo: Decodable {
    let likes: Int
    let urls : Sizes
    let user: User
}

struct Sizes: Decodable {
    let small: String
    let full: String
}

struct User: Decodable {
    let name: String
}
