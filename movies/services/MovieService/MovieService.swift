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
    var randomMovieId: BehaviorRelay<Int?> = BehaviorRelay<Int?>(value: nil)
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func getPrimaryMovie() {
        apiClient.call(endpoint: MovieEndpoint.getDailyMovie([]).endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (movieResponse: MovieResponse) in
            let randomPage = Int.random(in: 1...movieResponse.totalPages)
            
            self?.apiClient.call(endpoint: MovieEndpoint.getDailyMovie([URLQueryItem(name: "page", value: String(randomPage))]).endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [unowned self] (movieResponse1: MovieResponse) in
                let randomId = Int.random(in: 1...movieResponse1.results.count - 1)
                let movieId = movieResponse1.results[randomId].id
                self!.randomMovieId.accept(movieId)
            }).disposed(by: self!.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func getMovieById(id: Int) {
        apiClient.call(endpoint: MovieEndpoint.getMovieById(id).endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (movie: MovieDetails) in
            self?.movie.accept(movie)
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
            return movieVideoData
        }.asObservable()
    }
}
