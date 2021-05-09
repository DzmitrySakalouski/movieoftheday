//
//  SignUpViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {
    // MARK: properties
    private var disposeBag = DisposeBag()
    var viewModel: SignUpViewModelType!
    
    // MARK: outlets
    @IBOutlet weak var signInLabel: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: TextInput!
    @IBOutlet weak var passwordTextField: TextInput!
    @IBOutlet weak var emailTextField: TextInput!
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmPasswordTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        configureObservers()
        configureCallbacks()
    }
    
    // MARK: configure
    func configureObservers() {
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailViewModel.data).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordViewModel.data).disposed(by: disposeBag)
        confirmPasswordTextField.rx.text.orEmpty.bind(to: viewModel.confirmPasswordViewModel.data).disposed(by: disposeBag)
        
        viewModel.emailViewModel.errorValue.subscribe(onNext: {[unowned self] errorMessage in
            emailTextField.errorLabel.text = errorMessage
        }).disposed(by: disposeBag)
        
        viewModel.passwordViewModel.errorValue.subscribe(onNext: {[unowned self] errorMessage in
            passwordTextField.errorLabel.text = errorMessage
        }).disposed(by: disposeBag)
        
        viewModel.confirmPasswordViewModel.errorValue.subscribe(onNext: {[unowned self] errorMessage in
            confirmPasswordTextField.errorLabel.text = errorMessage
        }).disposed(by: disposeBag)
    }

    func configureCallbacks() {
        signInLabel.rx.tap.bind(onNext: { [unowned self] in
            self.viewModel.didPressSignInLabel?()
        }).disposed(by: disposeBag)
        
        signUpButton.rx.tap.bind(onNext: {[unowned self] in
            if self.viewModel.validateCredetials() {
                self.viewModel.register()
            }
        }).disposed(by: disposeBag)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
