//
//  File.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

protocol CoordinatorOutputType: class {
    var finishFlow: (() -> Void)? { get set }
}
