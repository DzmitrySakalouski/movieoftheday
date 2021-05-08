//
//  APIClientType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation
import RxSwift

protocol APIClientType {
    var networkService: NetworkServiceType! { get set }
    func call<T: Codable>(endpoint: EndpointType) -> Observable<T>
    func callWithBody<T: Codable>(endpoint: EndpointType, body: T) -> Observable<T>
    func image(url: URL) -> Observable<UIImage?>
}
