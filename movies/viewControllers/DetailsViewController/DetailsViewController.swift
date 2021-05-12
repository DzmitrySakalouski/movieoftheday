//
//  DetailsViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 2.04.21.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModelType!
    let disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BebasNeue-Regular", size: 32)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BebasNeue-Regular", size: 16)
        label.textColor = Colors.textGray.getColor()
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Get more details", for: .normal)
        button.titleLabel?.font = UIFont(name: "BebasNeue-Regular", size: 18)
        button.titleLabel?.textColor = .red
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        return button
    }()
    
    lazy var backgroundTopImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addBlur(0.95)
        return imageView
    }()
    
    lazy var imageContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 10
        return container
    }()
    
    lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "BebasNeue-Regular", size: 16)
        return label
    }()
    
    var voteItem: DetailsStack = {
        let detailsItem = DetailsStack()
        detailsItem.image = UIImage(systemName: "star.fill")?.withTintColor(UIColor(red: 252/255, green: 196/255, blue: 25/255, alpha: 1), renderingMode: .alwaysOriginal)
        return detailsItem
    }()
    
    var budgetItem: DetailsStack = {
        let detailsItem = DetailsStack()
        detailsItem.image = UIImage(systemName: "dollarsign.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return detailsItem
    }()
    
    var countItem: DetailsStack = {
        let detailsItem = DetailsStack()
        detailsItem.image = UIImage(systemName: "plus.bubble")?.withTintColor(UIColor(red: 81/255, green: 207/255, blue: 102/255, alpha: 1), renderingMode: .alwaysOriginal)
        return detailsItem
    }()
    
    var allDetailsStack: UIStackView = {
        let detailsStack = UIStackView()
        detailsStack.axis = .horizontal
        detailsStack.distribution = .equalSpacing
        return detailsStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureBinding()
        viewModel?.getVideoTrailerData()
    }
    
    func configureView() {
        view.addSubview(imageContainer)
        imageContainer.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: UIScreen.main.bounds.height * 0.5)
        
        imageContainer.addSubview(backgroundTopImage)
        backgroundTopImage.anchor(top: imageContainer.topAnchor, left: imageContainer.leftAnchor, bottom: imageContainer.bottomAnchor, right: imageContainer.rightAnchor)
        
        backgroundTopImage.addSubview(titleLabel)
        titleLabel.anchor(bottom: backgroundTopImage.bottomAnchor, right: view.rightAnchor, paddingBottom: 50, paddingRight: 20, width: UIScreen.main.bounds.width * 0.5)
        
        imageContainer.addSubview(taglineLabel)
        taglineLabel.anchor(top: titleLabel.bottomAnchor, right: imageContainer.rightAnchor, paddingTop: 5, paddingRight: 20)
                
        // TODO move to extension
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        
        allDetailsStack.addArrangedSubview(voteItem)
        allDetailsStack.addArrangedSubview(countItem)
        allDetailsStack.addArrangedSubview(budgetItem)
        view.addSubview(allDetailsStack)
        allDetailsStack.anchor(top: imageContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        let label = UILabel()
        label.font = UIFont(name: "BebasNeue-Regular", size: 24)
        label.text = "Overview"
        view.addSubview(label)
        label.anchor(top: allDetailsStack.bottomAnchor, left: view.leftAnchor, paddingTop: 25, paddingLeft: 20)
        
        view.addSubview(overviewLabel)
        overviewLabel.numberOfLines = 0
        overviewLabel.anchor(top: label.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
    }

    func configureBinding() {
        viewModel.movieImage.subscribe(onNext: {[weak self] image in
            self?.backgroundTopImage.image = image
        }).disposed(by: disposeBag)
        
        viewModel?.movie.subscribe(onNext: { [weak self] movie in
            self?.titleLabel.text = movie?.title.uppercased()
            self?.taglineLabel.text = movie?.tagline
            self?.overviewLabel.text = movie?.overview
            if let voteAverage = movie?.voteAverage, let revenue = movie?.revenue, let voteCount = movie?.voteCount {
                self?.voteItem.value = "\(String(voteAverage))/10"
                self?.budgetItem.value = String(revenue)
                self?.countItem.value = String(voteCount)
            }
        }).disposed(by: disposeBag)
        
//        viewModel.movieService.movieVideoData.subscribe(onNext: {[unowned self] movieVideo in
//            guard let key = movieVideo?.results[0].key else { return }
//            self.youtubePlayer.loadVideoID(key)
//        }).disposed(by: disposeBag)
        
        button.rx.tap.bind(onNext: {
            print("Hello")
        }).disposed(by: disposeBag)
    }
}
