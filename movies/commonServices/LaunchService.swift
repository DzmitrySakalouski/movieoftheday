//
//  LaunchService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 9.05.21.
//

import Foundation
import RxCocoa
import RxSwift

class LaunchService {
    var launchInstructor: BehaviorRelay<Launcher?> = BehaviorRelay<Launcher?>(value: nil)
    var userService: UserServiceType!
    
    var disposeBag = DisposeBag()
    
    init(userService: UserServiceType) {
        self.userService = userService
    }
    
    func configure() {
        userService.user.subscribe(onNext: {[unowned self] user in
            if user != nil {
                launchInstructor.accept(.home)
            } else {
                launchInstructor.accept(.auth)
            }
        }).disposed(by: disposeBag)
    }
}
