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
    
    var horizontalDetailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        return stack
    }()
    
    var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2000"
        label.textColor = Colors.textGray.getColor()
        label.font = UIFont(name: "ProximaNova-Light", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var runTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "1h 30m"
        label.textColor = Colors.textGray.getColor()
        label.font = UIFont(name: "ProximaNova-Light", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var genresStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        return stack
    }()
    
    var countryLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont(name: "ProximaNova-Light", size: 15)
        return l
    }()
    
    var genresLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont(name: "ProximaNova-Light", size: 15)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = .white

        setupScrollView()
        setupViews()
        configureSubscriptions()
        
        viewModel.getVideoTrailerData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [unowned self] in
            self.imageContainer.addSubview(self.frontImageView)
            self.frontImageView.anchor(top: self.imageContainer.topAnchor, left: self.imageContainer.leftAnchor, paddingTop: 60, paddingLeft: 20, width: 100, height: 160)
            print(viewModel.movie.value?.productionCountries)
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
        movieDetailsContainer.anchor(top: imageContainer.bottomAnchor, paddingTop: -39)
        movieDetailsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieDetailsContainer.widthAnchor.constraint(equalToConstant:  UIScreen.main.bounds.width / 2).isActive = true
        movieDetailsContainer.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        configureDetailsStackStack()
        configureHorizontalDetailsStack()
            
        contentView.addSubview(overviewLabelTitle)
        overviewLabelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        overviewLabelTitle.topAnchor.constraint(equalTo: genresStack.bottomAnchor, constant: 25).isActive = true
        overviewLabelTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
        
        contentView.addSubview(overviewLabel)
        overviewLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: overviewLabelTitle.bottomAnchor, constant: 25).isActive = true
        overviewLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
    }

    func setupScrollView(){
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
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
        contentView.addSubview(countryLabel)
        countryLabel.anchor(top: imageContainer.bottomAnchor, left: contentView.leftAnchor, right: movieDetailsContainer.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        movieDetailsContainer.addSubview(voteItem)
        voteItem.anchor(left: movieDetailsContainer.leftAnchor, paddingLeft: 30)
        voteItem.centerYAnchor.constraint(equalTo: movieDetailsContainer.centerYAnchor).isActive = true
        
        movieDetailsContainer.addSubview(trailerItem)
        trailerItem.translatesAutoresizingMaskIntoConstraints = false
        trailerItem.centerYAnchor.constraint(equalTo: movieDetailsContainer.centerYAnchor).isActive = true
        trailerItem.anchor(right: movieDetailsContainer.rightAnchor, paddingRight: 30)
    }
    
    func configureHeader() {
        imageContainer.addSubview(titleLabel)
        titleLabel.anchor(right: imageContainer.rightAnchor, paddingRight: 20, width: UIScreen.main.bounds.width / 2)
        titleLabel.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
    }
    
    func configureHorizontalDetailsStack() {
        horizontalDetailsStack.addArrangedSubview(yearLabel)
        horizontalDetailsStack.addArrangedSubview(runTimeLabel)
        
        contentView.addSubview(horizontalDetailsStack)
        horizontalDetailsStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
        horizontalDetailsStack.topAnchor.constraint(equalTo: movieDetailsContainer.bottomAnchor, constant: 20).isActive = true
        horizontalDetailsStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(genresStack)
        genresStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
        genresStack.topAnchor.constraint(equalTo: horizontalDetailsStack.bottomAnchor, constant: 15).isActive = true
        genresStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        genresStack.addArrangedSubview(genresLabel)
    }
    
    func configureSubscriptions() {
        viewModel.movieImage.subscribe(onNext: { [weak self] image in
            self?.imageContainer.image = image
            self?.frontImageView.image = image
        }).disposed(by: disposeBag)
        
        viewModel.movieService.movieVideoData.subscribe(onNext: {[weak self] videodData in
            self?.trailerItem.onPress = {
                guard let video = videodData?.results else { return }
                if video.count > 0 {
                    if video[0].site == "YouTube" {
                        let url = URL(string: "https://www.youtube.com/watch?v=\(video[0].key)")!
                        UIApplication.shared.open(url)
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        
        viewModel.movie.subscribe(onNext: {[weak self] movie in
            self?.overviewLabel.text = movie?.overview
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-mm-dd"
            let date = dateFormatterGet.date(from: movie!.releaseDate)
            
            let dateFormatSet = DateFormatter()
            dateFormatSet.dateFormat = "YYYY, MMM dd"
            
            let dateString = dateFormatSet.string(from: date!)
            
            self?.yearLabel.text = dateString
        
            if let voteAverage = movie?.voteAverage, let runtime = movie?.runtime {
                self?.voteItem.value = "\(String(voteAverage))/10"
                self?.runTimeLabel.text = self?.getRuntime(runtime)
            }
            self?.titleLabel.text = movie?.title
            
            self?.renderGenres(genres: movie?.genres)
            self?.renderCountries(countries: movie?.productionCountries)
        }).disposed(by: disposeBag)
    }
    
    private func renderCountries(countries: [ProductionCountry]?) {
        guard let countriesArray = countries else {
            return
        }
        
        var countriesString = ""
        
        countriesArray.forEach{ country in
            countriesString = countriesString + "\(country.iso_3166_1) "
        }
        
        countryLabel.text = countriesString
    }
    
    private func renderGenres(genres: [Genre]?) {
        guard let genresList = genres else {
            return
        }
        
        var genresString = ""
        
        genresList.forEach{ genre in
            genresString = genresString + "\(genre.name) "
        }
        
        genresLabel.text = genresString
    }
    
    private func getRuntime(_ runtimeMinutes: Int?) -> String {
        guard let runtime = runtimeMinutes else {
            return ""
        }
        
        let runtimeString = "\(runtime/60)h \(runtime%60)min"
        
        return runtimeString
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
