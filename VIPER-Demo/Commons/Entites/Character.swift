//
//  Location.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 09/09/2022.
//

import Foundation

struct CharactersResponse: Codable {
    let info: ResponseInfo
    let results: [Character]
}

struct ResponseInfo: Codable {
    let pages: Int
    let next: String
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: CharacterLocation
}

struct CharacterLocation: Codable {
    let name: String
    let url: String
}
