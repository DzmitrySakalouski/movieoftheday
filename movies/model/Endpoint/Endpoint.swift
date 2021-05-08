//
//  File.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation

struct Endpoint: EndpointType {
    var baseUrl: String = BASE_URL
    var path: String
    var parameters: [URLQueryItem]
    var method: HTTPMethod
}
