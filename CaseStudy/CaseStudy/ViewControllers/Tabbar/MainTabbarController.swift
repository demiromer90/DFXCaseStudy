//
//  MainTabbarController.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import UIKit

class MainTabbarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        if let firstItem = tabBar.items?.first {
            firstItem.title = "Discover".localized()
        }
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let _ = viewController as? DiscoverViewController {
            return true
        }else{
            showAlert(title: "Warning".localized(), message: "Coming Soon".localized())
            return false
        }
        
    }
    
}
