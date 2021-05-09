//
//  LaunchService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation

fileprivate var onboardingWasShown = false
fileprivate var isAutorized = false

enum Launcher {
    case auth, home, onbording
    
    static func configure(onbordingShown: Bool = onboardingWasShown, isAuthenticated: Bool = isAutorized) -> Launcher {
        switch (onbordingShown, isAuthenticated) {
        case (true, false): return .auth
        case (false, true), (false, false): return .auth // .onbording
        case (true, true): return .home
        }
    }
}
