//
//  InitialMovieViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 3.04.21.
//

import UIKit
import RxSwift

class InitialPagerViewController: UIPageViewController {
    var activityView: UIActivityIndicatorView?
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "BebasNeue-Regular", size: 32)
        l.text = "Moonlight"
        return l
    }()
    
    lazy var settingsBarItem: UIBarButtonItem = {
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(onSettingsPress))
        settingsItem.tintColor = .white
        return settingsItem
    }()
    
    lazy var frontImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var primaryButton: UIButton = {
        let primaryBtn = UIButton()
        primaryBtn.setTitle("Get more details", for: .normal)
        primaryBtn.titleLabel?.font = UIFont(name: "BebasNeue-Regular", size: 18)
        primaryBtn.titleLabel?.textColor = .white
        primaryBtn.titleLabel?.textAlignment = .center
        primaryBtn.layer.borderColor = UIColor.gray.cgColor
        primaryBtn.layer.borderWidth = 0.5
        primaryBtn.addTarget(self, action: #selector(onDetailsPress), for: .touchUpInside)
        return primaryBtn
    }()
    
    
    var disposeBag = DisposeBag()
    
    var currentIndex: Int = 0
    var pages: [UIViewController]?
    
    var viewModel: InitialMovieViewModelType!
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
        viewModel?.movieService.getPrimaryMovie()
        dataSource = self
        delegate = nil
        
        guard let pageList = pages else {
            return
        }
        setViewControllers([pageList[0]], direction: .forward, animated: false, completion: nil)
        
        configureView()
    }
    
    var viewContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let v = UIView()
    
    var xPicConstraint: NSLayoutConstraint?
    
    func configureView() {
        if let scrollView = self.view.subviews.filter({$0.isKind(of: UIScrollView.self)}).first as? UIScrollView {
            scrollView.isScrollEnabled = false
        }
        
        view.addSubview(viewContainer)
        viewContainer.isUserInteractionEnabled = true

        viewContainer.anchor( width: UIScreen.main.bounds.width, height: 450)
        viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        viewContainer.addSubview(frontImage)
        frontImage.anchor(top: viewContainer.topAnchor, width: 220, height: 340)
        
        self.xPicConstraint = frontImage.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
        xPicConstraint?.isActive = true
        viewContainer.addSubview(label)
        label.anchor(top: frontImage.bottomAnchor, paddingTop: 20)
        label.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true

        viewContainer.addSubview(primaryButton)
        primaryButton.anchor(top: label.bottomAnchor, paddingTop: 20, width: UIScreen.main.bounds.width * 0.7, height: 50)
        primaryButton.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func showLoader() {
        primaryButton.isHidden = true
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .white
        activityView?.tintColor = .white

        activityView?.center = view.center
        view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideLoader() {
        if (activityView != nil){
            primaryButton.isHidden = false

            activityView?.stopAnimating()
        }
    }
    
    func configureBinding() {
        viewModel.isLoading.subscribe(onNext: {[weak self] isLoading in
            if isLoading {
                self?.showLoader()
            } else {
                self?.hideLoader()
            }
        }).disposed(by: disposeBag)
        
        viewModel.movieService.randomMovieId.subscribe(onNext: {[unowned self] id in
            guard let movieId = id else { return }
            self.viewModel.fetchMovie(id: movieId)
        }).disposed(by: disposeBag)
        
        viewModel?.movie.subscribe(onNext: { [weak self] movie in
            if movie != nil {
                self?.viewModel.isLoading.accept(false)
            }
            self?.label.text = movie?.title
        }).disposed(by: disposeBag)
        
        viewModel?.movieImage.subscribe(onNext: { [weak self] image in
            self?.frontImage.image = image
        }).disposed(by: disposeBag)
        
        guard let pageList = pages else {
            return
        }
                        
        viewModel.currentIndex.subscribe(onNext: { [weak self] index in
            self?.setViewControllers([pageList[index]], direction: .forward, animated: true, completion: nil)
            if index == 1 {
                self?.xPicConstraint?.isActive = false
                self?.frontImage.anchor(top: self?.view.topAnchor, left: self?.view.leftAnchor, paddingTop: 60, paddingLeft: 20, width: 100, height: 160)
                self?.viewContainer.anchor(width: 0, height: 0)
                self?.primaryButton.removeFromSuperview()
                self?.label.removeFromSuperview()
                
                UIView.animate(withDuration: 0.5, animations: {() -> Void in
                    self?.view.layoutIfNeeded()
                    self?.label.textColor = .clear
                    self?.primaryButton.tintColor = .clear
                }, completion: { [weak self] _ in
                    self?.frontImage.removeFromSuperview()
                })
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func onDetailsPress() {
        viewModel?.switchIndex()
    }
    
    @objc func onSettingsPress() {
        viewModel.didSettingsPress()
    }
}

extension InitialPagerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let pageList = pages else {
            return UIViewController()
        }
        
        guard let viewControllerIndex = pageList.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return pageList.last }

        guard pageList.count > previousIndex else { return nil }

        return pageList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageList = pages else {
            return UIViewController()
        }
        
        guard let viewControllerIndex = pageList.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pageList.count else { return pageList.first }

        guard pageList.count > nextIndex else { return nil }

        return pageList[nextIndex]
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int { return 0 }
}

