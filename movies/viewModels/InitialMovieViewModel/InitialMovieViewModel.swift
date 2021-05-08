//
//  InitialMovieViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 3.04.21.
//

import Foundation
import RxCocoa

class InitialMovieViewModel: InitialMovieViewModelType {
    var currentIndex: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var movieService: MovieServiceType!
    var movie: BehaviorRelay<Movie?>!
    var movieImage: BehaviorRelay<UIImage?>!
    
    init(movieService: MovieServiceType) {
        self.movieService = movieService
        movie = movieService.movie
        movieImage = movieService.movieImage
    }
    
    func fetchMovie() {
        movieService?.getPrimaryMovie()
    }
    
    func switchIndex() {
        self.currentIndex.accept(1)
    }
}
