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
    let scrollView = UIScrollView()
    let contentView = UIView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BebasNeue-Regular", size: 24)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
        
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont(name: "ProximaNova-Light", size: 15)
        label.sizeToFit()
        label.textColor = Colors.textGray.getColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let frontImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let overviewLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "Plot summary".uppercased()
        label.numberOfLines = 0
        label.font = UIFont(name: "BebasNeue-Regular", size: 32)
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageContainer: UIImageView = {
        let imageContainerView = UIImageView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.backgroundColor = .systemGray
        imageContainerView.addBlur(1)
        return imageContainerView
    }()
    
    var movieDetailsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 20
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    var voteItem: DetailsStack = {
        let detailsItem = DetailsStack()
        detailsItem.image = UIImage(systemName: "star.fill")?.withTintColor(UIColor(red: 252/255, green: 196/255, blue: 25/255, alpha: 1), renderingMode: .alwaysOriginal)
        return detailsItem
    }()
        
    var trailerItem: DetailsStack = {
        let detailsItem = DetailsStack()
        detailsItem.value = "Trailer"
        detailsItem.image = #imageLiteral(resourceName: "youtube")
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
        configureNavBar()
        view.backgroundColor = .white

        setupScrollView()
        setupViews()
        configureSubscriptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [unowned self] in
            self.imageContainer.addSubview(self.frontImageView)
            self.frontImageView.anchor(top: self.imageContainer.topAnchor, left: self.imageContainer.leftAnchor, paddingTop: 60, paddingLeft: 20, width: 100, height: 160)
        }
    }
    
    func setupViews(){
        contentView.addSubview(imageContainer)
        imageContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        configureHeader()
        
        contentView.addSubview(movieDetailsContainer)
        movieDetailsContainer.anchor(top: imageContainer.bottomAnchor, paddingTop: -15)
        movieDetailsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        movieDetailsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieDetailsContainer.heightAnchor.constraint(equalToConstant: 89).isActive = true
        
        configureDetailsStackStack()
            
        contentView.addSubview(overviewLabelTitle)
        overviewLabelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        overviewLabelTitle.topAnchor.constraint(equalTo: movieDetailsContainer.bottomAnchor, constant: 25).isActive = true
        overviewLabelTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
        
        contentView.addSubview(overviewLabel)
        overviewLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: overviewLabelTitle.bottomAnchor, constant: 25).isActive = true
        overviewLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func setupScrollView(){
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func configureDetailsStackStack() {
        movieDetailsContainer.addSubview(voteItem)
        voteItem.anchor(left: movieDetailsContainer.leftAnchor, paddingLeft: 30)
        voteItem.centerYAnchor.constraint(equalTo: movieDetailsContainer.centerYAnchor).isActive = true
        
        movieDetailsContainer.addSubview(trailerItem)
        trailerItem.translatesAutoresizingMaskIntoConstraints = false
        trailerItem.centerYAnchor.constraint(equalTo: movieDetailsContainer.centerYAnchor).isActive = true
        trailerItem.centerXAnchor.constraint(equalTo: movieDetailsContainer.centerXAnchor).isActive = true

        movieDetailsContainer.addSubview(countItem)
        countItem.anchor(right: movieDetailsContainer.rightAnchor, paddingRight: 30)
        countItem.centerYAnchor.constraint(equalTo: movieDetailsContainer.centerYAnchor).isActive = true
    }
    
    func configureHeader() {
        imageContainer.addSubview(titleLabel)
        titleLabel.anchor(right: imageContainer.rightAnchor, paddingRight: 20, width: UIScreen.main.bounds.width / 2)
        titleLabel.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
    }
    
    func configureSubscriptions() {
        viewModel.movieImage.subscribe(onNext: { [weak self] image in
            self?.imageContainer.image = image
            self?.frontImageView.image = image
        }).disposed(by: disposeBag)
        
        viewModel.movie.subscribe(onNext: {[weak self] movie in
            self?.overviewLabel.text = movie?.overview
            if let voteAverage = movie?.voteAverage, let voteCount = movie?.voteCount {
                self?.voteItem.value = "\(String(voteAverage))/10"
                self?.countItem.value = String(voteCount)
            }
            self?.titleLabel.text = movie?.title
        }).disposed(by: disposeBag)
    }
}

extension DetailsViewController {
    func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .white
    }
}



















//        viewModel.movieImage.subscribe(onNext: {[weak self] image in
//            self?.backgroundTopImage.image = image
//        }).disposed(by: disposeBag)
//        viewModel?.movie.subscribe(onNext: { [weak self] movie in
//            self?.titleLabel.text = movie?.title.uppercased()
//            self?.overviewLabel.text = "\(movie?.overview ?? "") \(movie?.overview ?? "") \(movie?.overview ?? "") \(movie?.overview ?? "") \(movie?.overview ?? "") \(movie?.overview ?? "")"
//        }).disposed(by: disposeBag)
//
//        viewModel.movieService.movieVideoData.subscribe(onNext: {[unowned self] movieVideo in
//            guard let key = movieVideo?.results[0].key else { return }
//            self.youtubePlayer.loadVideoID(key)
//        }).disposed(by: disposeBag)
        
//        button.rx.tap.bind(onNext: {
//            print("Hello")
//        }).disposed(by: disposeBag)
