//
//  LoginViewController.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput:CustomInput!
    @IBOutlet weak var passwordInput:CustomInput!
    @IBOutlet weak var forgotPassButton:UIButton!
    
    private let spinner = CommonIndicator()
    private let viewModel = LoginViewModel()
    
    
    //MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.delegate = self
    }
    
    private func setUI(){
        emailInput.textField.keyboardType = .emailAddress
        
        forgotPassButton.layer.cornerRadius = forgotPassButton.frame.size.height / 2.0
        forgotPassButton.layer.borderWidth = 1.0
        forgotPassButton.layer.borderColor = UIColor.xBlue.cgColor
    }
    
    @IBAction func onLogin(){
        let email = emailInput.text()
        let password = passwordInput.text()
        
        if viewModel.isValidInput(email: email, password: password) {
            viewModel.loginWith(email: email, password: password)
        }
    }
    

}



//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    
    func emailNotValid() {
        emailInput.setState(state: .fail)
    }
    
    func passwordNotValid() {
        passwordInput.setState(state: .fail)
    }
    
    func serviceError(error: Error) {
        showError(error: error)
    }
    
    func loginSuccess() {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: "MainTabbarController")
        rootVC.view.frame = UIScreen.main.bounds
        rootVC.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = rootVC
            UIView.setAnimationsEnabled(oldState)
        }, completion: { completed in
        })
        
    }
    
    func triggerSpinner(isShow: Bool) {
        if isShow {
            spinner.startAnimatingOnView(view: view)
        }else{
            spinner.stopAnimating()
        }
    }
    
}
