//
//  Movie.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation

struct Movie: Codable {
    var posterPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var video: Bool
    var popularity: Double
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case video = "video"
        case popularity = "popularity"
        case id = "id"
    }
}

struct MovieResponse: Codable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}