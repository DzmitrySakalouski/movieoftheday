//
//  ValidationType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ValidationType {
    var errorMessage: String { get }
    
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get }
    
    func validate() -> Bool
}
