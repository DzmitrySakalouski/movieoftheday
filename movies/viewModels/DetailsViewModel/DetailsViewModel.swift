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
    var movie: BehaviorRelay<Movie?>!
    var movieImage: BehaviorRelay<UIImage?>!
    
    init(movieService: MovieServiceType) {
        self.movieService = movieService
        self.movie = movieService.movie
        self.movieImage = movieService.movieImage
    }
}
