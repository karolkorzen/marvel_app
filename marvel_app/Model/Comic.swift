//
//  Comic.swift
//  marvel_app
//
//  Created by Karol Korzeń on 17/01/2021.
//

import Foundation

class RawComicsResponse: Codable {
    let data: RawDataResponse
}

class RawDataResponse: Codable {
    let results: [Comic]
}

class Comic: Codable {
    let id: Int
    let title: String
    let description: String?
    let creators: RawCreators
    let thumbnail: RawThumbnail
    let urls: [RawUrls]
}


class RawUrls: Codable {
    let type: String
    let url: String
}

class RawThumbnail: Codable {
    let path: String
}

class RawCreators: Codable {
    let items: [Creator]
}

class Creator: Codable {
    let name: String
    let role: String
}
