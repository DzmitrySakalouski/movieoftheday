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
    var movie: BehaviorRelay<Movie?>!
    var movieImage: BehaviorRelay<UIImage?>!
    var disposeBag = DisposeBag()
    
    // TODO move to settings
    var authService: AuthServiceType!
    
    init(movieService: MovieServiceType, authService: AuthServiceType) {
        self.movieService = movieService
        movie = movieService.movie
        movieImage = movieService.movieImage
        self.authService = authService
    }
    
    func fetchMovie() {
        movieService?.getPrimaryMovie()
    }
    
    func switchIndex() {
        self.currentIndex.accept(1)
    }
    
    func didSettingsPress() -> () {
        authService.signOut().subscribe(onError: {error in
            // TODO: add error handling
            print(error)
        }).disposed(by: disposeBag)
    }
}
