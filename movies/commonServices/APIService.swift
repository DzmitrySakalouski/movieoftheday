//
//  APIManager.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation
import RxSwift

class APIClient: APIClientType {
    private let disposeBag: DisposeBag = DisposeBag()
    var networkService: NetworkServiceType!
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func call<T: Codable>(endpoint: EndpointType) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            self?.networkService.makeRequest(endpoint: endpoint) { (result: Result<T, Error>) in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func callWithBody<T: Codable>(endpoint: EndpointType, body: T) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            self?.networkService.makeRequestWithBody(endpoint: endpoint, body: body) { (result: Result<T, Error>) in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func image(url: URL) -> Observable<UIImage?> {
        return Observable<UIImage?>.create { [weak self] observer in
            self?.networkService.loadImage(from: url) { (result: Result<UIImage?, Error>) in
                switch result {
                case .success(let image):
                    observer.onNext(image)
                
                case .failure(let error):
                    observer.onError(error)
                }
                
            }
            return Disposables.create()
        }
    }
}
