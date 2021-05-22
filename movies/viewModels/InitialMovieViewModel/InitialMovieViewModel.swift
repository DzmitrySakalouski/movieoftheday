//
//  InitialMovieViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 3.04.21.
//

import Foundation
import RxCocoa
import RxSwift

class InitialMovieViewModel: InitialMovieViewModelType {    
    var currentIndex: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var movieService: MovieServiceType!
    var movie: BehaviorRelay<MovieDetails?>!
    var movieImage: BehaviorRelay<UIImage?>!
    var disposeBag = DisposeBag()
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    
    // TODO move to settings
    var authService: AuthServiceType!
    
    init(movieService: MovieServiceType, authService: AuthServiceType) {
        self.movieService = movieService
        movie = movieService.movie
        movieImage = movieService.movieImage
        self.authService = authService
    }
    
    func fetchMovie(id: Int) {
        movieService?.getMovieById(id: id)
    }
    
    func switchIndex() {
        self.currentIndex.accept(1)
    }
    
    func didNoAdsPress() -> () {
        print("No ads")
    }
    func didRefreshPress() -> () {
        print("Refresh")
        movieService.getPrimaryMovie()
    }
}
