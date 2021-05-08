//
//  TextInput.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.05.21.
//

import UIKit
@IBDesignable
class TextInput: UITextField {
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            setupUI()
        }
    }
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "DIN Alternate Bold", size: 14)
        return label
    }()
    
    var errorMessage: String? {
        didSet {
            if errorMessage != nil {
                self.errorLabel.text = errorMessage
                self.borderColor = .red
            } else {
                self.borderColor = .black
                self.errorLabel.text = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
        
    private func setupUI() {
        let border = UIView()
        borderStyle = .none
        textColor = .black
        let color: UIColor = .gray
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : color])

        addSubview(border)
        
        border.backgroundColor = self.borderColor
        
        border.anchor(top: bottomAnchor, left: leftAnchor, right: rightAnchor, height: 1)
        border.isUserInteractionEnabled = false
        
        addSubview(errorLabel)
        errorLabel.anchor(top: border.bottomAnchor, left: border.leftAnchor, paddingTop: 5)
    }

}
