//
//  DetailsViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 4.04.21.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsViewModel: DetailsViewModelType {
    var movieService: MovieServiceType!
    var movie: BehaviorRelay<MovieDetails?>!
    var movieImage: BehaviorRelay<UIImage?>!
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    
    var disposeBag = DisposeBag()
    
    init(movieService: MovieServiceType) {
        self.movieService = movieService
        self.movie = movieService.movie
        self.movieImage = movieService.movieImage
    }
    
    func getVideoTrailerData() {
        guard let movieData = movie.value else {
            return
        }
        movieService.getTrailerData(for: movieData.id).subscribe(onCompleted: {[unowned self] in
            isLoading.accept(false)
        }).disposed(by: disposeBag)
    }
}
