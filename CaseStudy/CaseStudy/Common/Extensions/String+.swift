//
//  String+.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import Foundation

extension String {
    
    func localized(with arg:[CVarArg] = [])->String{
        return String(format:NSLocalizedString(self, comment:""), arguments: arg)
    }
    
    func isValidEmail() -> Bool {
        guard self.count < 66 else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        if self.count >= 6, self.count < 21 {
            return true
        }
        
        return false
    }
}

