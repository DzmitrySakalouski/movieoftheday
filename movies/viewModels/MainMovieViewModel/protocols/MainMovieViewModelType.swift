//
//  MainMovieViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation
import RxCocoa

protocol MainMovieViewModelType {
    var movieService: MovieServiceType! { get set }
    var movieImage: BehaviorRelay<UIImage?>! { get set }
//    var didPressShowDetails: (() -> ())? { get set }
//    var didPressSettings: (() -> ())? { get set }
}
