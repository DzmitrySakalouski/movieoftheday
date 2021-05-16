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
    var randomMovieId: BehaviorRelay<Int?> { get } 
    var movie: BehaviorRelay<MovieDetails?> { get set }
    var movieImage: BehaviorRelay<UIImage?> { get set }
    var movieVideoData: BehaviorRelay<VideoResponse?> { get set }
    func getPrimaryMovie() -> ()
    func loadImage(path: String) -> ()
    func getTrailerData(for id: Int)  -> Observable<VideoResponse?>
    func getMovieById(id: Int) -> ()
}
