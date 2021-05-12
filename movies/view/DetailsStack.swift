//
//  DetailsStack.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 12.05.21.
//

import UIKit

class DetailsStack: UIStackView {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star.fill")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var value: String = "" {
        didSet {
            label.text = value
        }
    }
    
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }

    lazy var labelContainer: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "BebasNeue-Regular", size: 17)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        axis = .vertical
        alignment = .center
        spacing = 4
        labelContainer.addSubview(label)
        label.anchor(top: labelContainer.topAnchor, left: labelContainer.leftAnchor, bottom: labelContainer.bottomAnchor, right: labelContainer.rightAnchor)
        addArrangedSubview(imageView)
        addArrangedSubview(labelContainer)
        imageView.anchor(width: 50, height: 50)
    }

}
