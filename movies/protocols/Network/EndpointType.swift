//
//  EndpointType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

protocol EndpointType {
    var path: String { get }
    var parameters: [URLQueryItem] { get set }
    var method: HTTPMethod { get }
}
