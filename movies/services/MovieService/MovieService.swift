//
//  MovieService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation
import RxCocoa
import RxSwift

class MovieService: MovieServiceType {
    var apiClient: APIClientType!
    var disposeBag = DisposeBag()
    var movie: BehaviorRelay<Movie?> = BehaviorRelay<Movie?>(value: nil)
    var movieImage: BehaviorRelay<UIImage?> = BehaviorRelay<UIImage?>(value: nil)
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func getPrimaryMovie() {
        apiClient.call(endpoint: MovieEndpoint.getDailyMovie([]).endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (movie: MovieResponse) in
            self?.movie.accept(movie.results[0])
            if let imagePath = movie.results[0].posterPath {
                self?.loadImage(path: imagePath)
            }
        }).disposed(by: disposeBag)
    }
    
    func loadImage(path: String) {
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")!
        apiClient.image(url: imageURL).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] image in
            self?.movieImage.accept(image)
        }).disposed(by: disposeBag)
    }
}
