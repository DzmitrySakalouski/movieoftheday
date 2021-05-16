//
//  OnboardingViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 16.05.21.
//

import UIKit

class OnboardingViewController: UIViewController {
    var didPressSubscribeButton: (() -> ())?

    var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logoEntry")
        return imageView
    }()
    
    var contentContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "WELCOME!".uppercased()
        label.font = UIFont(name: "BebasNeue-Regular", size: 34)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.49/week after"
        label.font = UIFont(name: "BebasNeue-Regular", size: 14)
        label.textColor = Colors.textGray.getColor()
        return label
    }()
    
    var detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Have some free time? Would like to see a movie but do not know which one? We will help you. Trust fate - the app will choose a random movie for you. The choice will not disappoint you! Also the parameters of movie for display can be customized."
        label.numberOfLines = 0
        label.font = UIFont(name: "ProximaNova-Light", size: 15)
        return label
    }()
    
    lazy var primaryButton: UIButton = {
        let primaryBtn = UIButton()
        primaryBtn.setTitle("Start 7-day Free Trial", for: .normal)
        primaryBtn.titleLabel?.font = UIFont(name: "BebasNeue-Regular", size: 22)
        primaryBtn.titleLabel?.textColor = .black
        primaryBtn.tintColor = .black
        primaryBtn.setTitleColor(.black, for: .normal)
        primaryBtn.setTitleColor(.white, for: .highlighted)
        primaryBtn.titleLabel?.textAlignment = .center
        primaryBtn.layer.borderColor = UIColor.gray.cgColor
        primaryBtn.layer.borderWidth = 0.5
        primaryBtn.addTarget(self, action: #selector(onButtonPress), for: .touchUpInside)
        return primaryBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        view.addSubview(contentContainerView)
        contentContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
        contentContainerView.addSubview(logoImageView)
        logoImageView.anchor(top: contentContainerView.topAnchor, left: contentContainerView.leftAnchor, paddingTop: 40, width: 40, height: 40)
        
        contentContainerView.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: logoImageView.bottomAnchor, left: contentContainerView.leftAnchor, paddingTop: 30)
        
        contentContainerView.addSubview(detailsLabel)
        detailsLabel.anchor(top: welcomeLabel.bottomAnchor, left: contentContainerView.leftAnchor, right: contentContainerView.rightAnchor, paddingTop: 15)
        
        contentContainerView.addSubview(priceLabel)
        priceLabel.anchor(bottom: contentContainerView.bottomAnchor, paddingBottom: 30)
        priceLabel.centerXAnchor.constraint(equalTo: contentContainerView.centerXAnchor).isActive = true
        
        contentContainerView.addSubview(primaryButton)
        primaryButton.anchor(left: contentContainerView.leftAnchor, bottom: priceLabel.topAnchor, right: contentContainerView.rightAnchor, paddingBottom: 20, height: 50)
    }

    @objc func onButtonPress() {
        if didPressSubscribeButton != nil {
            didPressSubscribeButton!()
        }
    }
}

extension OnboardingViewController {
    func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .white
    }
}
