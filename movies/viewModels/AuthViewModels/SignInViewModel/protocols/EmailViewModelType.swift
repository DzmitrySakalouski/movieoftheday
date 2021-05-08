//
//  EmailViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation

protocol EmailViewModelType: ValidationType {
    func validatePattern(text: String) -> Bool
}
