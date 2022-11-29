//
//  LoginViewModel.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import Foundation

protocol LoginViewModelDelegate: ServiceViewModelProtocol {
    func emailNotValid()
    func passwordNotValid()
    func loginSuccess()
}

class LoginViewModel : ServiceViewModel {
    
    weak var delegate:LoginViewModelDelegate?
    
    //MARK: - Main
    func isValidInput(email:String, password:String) -> Bool {
        var isValid = true
        
        if !email.isValidEmail() {
            delegate?.emailNotValid()
            isValid = false
        }
        
        if !password.isValidPassword() {
            delegate?.passwordNotValid()
            isValid = false
        }
        
        return isValid
    }
    
    func loginWith(email:String, password:String) {
        delegate?.triggerSpinner(isShow: true)
        
        requestManager.loginWith(email: email, password: password) { [weak self] result in
            self?.delegate?.triggerSpinner(isShow: false)
            
            switch result {
            case .failure(let error):
                self?.delegate?.serviceError(error: error)
                
            case .success:
                self?.delegate?.loginSuccess()
                
            }
        }
    }
    
}
