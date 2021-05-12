//
//  Colors.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 12.05.21.
//

import Foundation
import UIKit

enum Colors {
    case gold
    case textGray
    case primaryGreen
    case black
    
    func getColor() -> UIColor {
        switch self {
        case .gold:
            return UIColor(red: 252/255, green: 196/255, blue: 25/255, alpha: 1)
        case .textGray:
            return UIColor(red: 115/255, green: 117/255, blue: 153/255, alpha: 1)
        case .black:
            return .black
        case .primaryGreen:
            return UIColor(red: 81/255, green: 207/255, blue: 102/255, alpha: 1)
        }
    }
}
