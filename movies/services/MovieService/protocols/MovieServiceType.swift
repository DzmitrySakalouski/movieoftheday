//
//  MovieServiceType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import Foundation
import RxCocoa
import RxSwift

protocol MovieServiceType {
    var apiClient: APIClientType!  { get set }
    var disposeBag: DisposeBag { get }
    var movie: BehaviorRelay<Movie?> { get set }
    var movieImage: BehaviorRelay<UIImage?> { get set }
    func getPrimaryMovie()
    func loadImage(path: String)
}
