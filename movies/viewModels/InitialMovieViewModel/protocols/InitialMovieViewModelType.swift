//
//  InitialMovieViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 3.04.21.
//

import Foundation
import RxCocoa

protocol InitialMovieViewModelType {
    var movieService: MovieServiceType! { get set }
    var currentIndex: BehaviorRelay<Int> { get set }
    var movie: BehaviorRelay<MovieDetails?>! { get set }
    var movieImage: BehaviorRelay<UIImage?>! { get set }
    func fetchMovie() -> ()
    func switchIndex() -> ()
    func didSettingsPress() -> ()
}
