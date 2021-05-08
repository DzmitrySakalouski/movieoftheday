//
//  MainMovieViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation
import RxCocoa

class MainMovieViewModel: MainMovieViewModelType {
    var movieService: MovieServiceType!
    var movieImage: BehaviorRelay<UIImage?>!
    
//    var didPressShowDetails: (() -> ())?
//    var didPressSettings: (() -> ())?
    
    init(movieService: MovieServiceType) {
        self.movieService = movieService
        movieImage = movieService.movieImage
    }

}
