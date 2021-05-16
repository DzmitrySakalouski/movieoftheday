//
//  File.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

protocol CoordinatorFactoryType {
    func makeMainMovieCoordinator(navigator: NavigatorType) -> MainMovieCoordinator
    func makeAuthCoordinator(navigator: NavigatorType) -> AuthCoordinator
    func makeOnboardingCoordinator(navigator: NavigatorType) -> OnboardingCoordinator
}
