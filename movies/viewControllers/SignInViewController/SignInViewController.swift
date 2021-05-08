//
//  SignInViewController.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.05.21.
//

import UIKit
import RxSwift

class SignInViewController: UIViewController {
    // MARK: properties
    var viewModel: SignInViewModelType!
    private var disposeBag = DisposeBag()
    
    // MARK: outlets
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: TextInput!
    @IBOutlet weak var emailTextField: TextInput!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: lifecycle
    override func viewDidLoad() {
        passwordTextField.delegate = self
        emailTextField.delegate = self
        super.viewDidLoad()
        configureCallbacks()
        configureObservers()
    }
    
    // MARK: configurations
    func configureObservers() -> () {
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailViewModel.data).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordViewModel.data).disposed(by: disposeBag)
        
        viewModel.emailViewModel.errorValue.subscribe(onNext: { [unowned self] errorValue in
            self.emailTextField.errorMessage = errorValue
        }).disposed(by: disposeBag)
        
        viewModel.passwordViewModel.errorValue.subscribe(onNext: { [unowned self] errorValue in
            self.passwordTextField.errorMessage = errorValue
        }).disposed(by: disposeBag)
    }
    
    func configureCallbacks() -> () {
        signUpButton.rx.tap.bind(onNext: { [unowned self] in
            self.onSignUpLabelPress()
        }).disposed(by: disposeBag)
        
        signInButton.rx.tap.bind(onNext: { [unowned self] in
            if self.viewModel.validateCredetials() {
                self.onSignInPress()
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: handlers
    @objc private func onSignInPress() -> () {
        guard let onSignInPress = viewModel.didPressSignIn else {
            return
        }
        
        onSignInPress()
    }
    
    private func onSignUpLabelPress() -> () {
        guard let onSignUpLabelPress = viewModel.didPressSignUp else {
            return
        }
        
        onSignUpLabelPress()
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
