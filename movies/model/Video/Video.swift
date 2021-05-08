//
//  Video.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation

struct Video: Codable {
    var id: String
    var key: String
    var name: String
    var site: String
    var type: String
    var urlString: String?
}

struct VideoResponse: Codable {
    var id: Int
    var results: [Video]
}
