//
//  UIImageView+.swift
//  CaseStudy
//
//  Created by Ömer Demir on 28.11.2022.
//

import UIKit

extension UIImageView {
    
    public func imageFromUrl(urlString: String?, placeHolderImage:UIImage?) {
        
        self.image = placeHolderImage
        
        if let urlS = urlString{
            
            ServiceManager.downloadImageFrom(urlString: urlS) { image in
                self.image = image
            }
            
        }
    }
    
}
