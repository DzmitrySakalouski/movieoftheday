//
//  MovieEndpoint.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation

enum MovieEndpoint {
    case getDailyMovie([URLQueryItem])
    case movieDetails(Int)
    
    var endpoint: Endpoint {
        switch self {
        case .getDailyMovie(let serchOptions):
            return Endpoint(path: "/3/movie/popular", parameters: getParameters(serchOptions), method: .get)
        case .movieDetails(let id):
            return Endpoint(path: "/3/movie/\(id)/videos", parameters: getParameters([]), method: .get)
        }
        
    }
    
    func getParameters(_ parameters: [URLQueryItem]) -> [URLQueryItem] {
        return defaultParams + parameters
    }
}