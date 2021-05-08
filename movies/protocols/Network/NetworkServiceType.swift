//
//  NetworkServiceType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation
import UIKit

protocol NetworkServiceType {
    func makeRequest<T: Codable>(endpoint: EndpointType, complition: @escaping (Result<T, Error>) -> ()) -> ()
    func makeRequestWithBody<T: Codable>(endpoint: EndpointType, body: T, complition: @escaping (Result<T, Error>) -> ())
    func loadImage(from url: URL?, complition: @escaping (Result<UIImage?, Error>) -> ())
}
