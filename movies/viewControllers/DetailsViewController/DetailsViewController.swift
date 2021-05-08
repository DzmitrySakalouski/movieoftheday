//
//  DetailsViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import UIKit
import YouTubePlayer
import RxSwift

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModelType!
    let disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var youtubePlayer: YouTubePlayerView = {
        let player = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        player.backgroundColor = .gray
        return player
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureView()
        configureBinding()
    }
    
    func configureView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(paddingLeft: 30)
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func configureBinding() {
        viewModel?.movie.subscribe(onNext: { [weak self] movie in
            self?.titleLabel.text = movie?.title
        }).disposed(by: disposeBag)
    }
}
