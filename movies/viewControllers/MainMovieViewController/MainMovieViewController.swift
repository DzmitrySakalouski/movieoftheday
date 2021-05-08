//
//  MainMovieViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import UIKit
import RxSwift

class MainMovieViewController: UIViewController {
    var viewModel: MainMovieViewModelType!
    let disposeBag = DisposeBag()

    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.addBlur(20)
        return imageView
    }()
    
    lazy var settingsBarItem: UIBarButtonItem = {
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        settingsItem.tintColor = .white
        return settingsItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurView()
        configureSubscriptions()
    }
    
    private func configurView() {
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        navigationItem.rightBarButtonItem = settingsBarItem
    }
    
    private func configureSubscriptions() {        
        viewModel?.movieImage.subscribe(onNext: { [weak self] image in
            guard let movieImage = image else { return }
            self?.backgroundImage.image = movieImage
        }).disposed(by: disposeBag)
    }
}
