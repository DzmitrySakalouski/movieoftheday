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
    var movie: BehaviorRelay<MovieDetails?> = BehaviorRelay<MovieDetails?>(value: nil)
    var movieImage: BehaviorRelay<UIImage?> = BehaviorRelay<UIImage?>(value: nil)
    var movieVideoData: BehaviorRelay<VideoResponse?> = BehaviorRelay<VideoResponse?>(value: nil)
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func getPrimaryMovie() {
//        apiClient.call(endpoint: MovieEndpoint.getDailyMovie([]).endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (movie: MovieResponse) in
//            self?.movie.accept(movie.results[0])
//            print(movie.results[0].id)
//            if let imagePath = movie.results[0].posterPath {
//                self?.loadImage(path: imagePath)
//            }
//        }).disposed(by: disposeBag)
    }
    
    func getMovieById() {
        apiClient.call(endpoint: MovieEndpoint.getMovieById(550).endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (movie: MovieDetails) in
            self?.movie.accept(movie)
            print(movie)
            if let imagePath = movie.posterPath {
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
    
    func getTrailerData(for id: Int) -> Observable<VideoResponse?> {
        return apiClient.call(endpoint: MovieEndpoint.movieVideo(id).endpoint).observe(on: MainScheduler.instance).map{[weak self] (movieVideoData: VideoResponse) in
            self?.movieVideoData.accept(movieVideoData)
            print(movieVideoData.results[0])
            return movieVideoData
        }.asObservable()
    }
}
