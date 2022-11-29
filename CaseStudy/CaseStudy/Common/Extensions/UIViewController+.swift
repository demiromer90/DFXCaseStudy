//
//  UIViewController+.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import UIKit


extension UIViewController {
    
    func showAlert(title:String, message:String, completed:(()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Okey", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            completed?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showError(error:Error){
        showAlert(title: "Warning".localized(), message: (error as NSError).domain)
    }
    
}
