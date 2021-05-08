//
//  DetailsViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 4.04.21.
//

import Foundation
import RxCocoa

protocol DetailsViewModelType  {
    var movieService: MovieServiceType! { get set }
    var movie: BehaviorRelay<Movie?>! { get set }
    var movieImage: BehaviorRelay<UIImage?>! { get set }
}
