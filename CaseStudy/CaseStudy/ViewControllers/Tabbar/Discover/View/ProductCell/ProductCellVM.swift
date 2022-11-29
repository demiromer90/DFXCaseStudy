//
//  ProductCellVM.swift
//  CaseStudy
//
//  Created by Ömer Demir on 29.11.2022.
//

import UIKit


class ProductCellVM: NSObject {
    let product:Product
    let imageRatio:CGFloat
    let descriptionFontSize:CGFloat
    
    init(product:Product, imageRatio:CGFloat, descriptionFontSize:CGFloat) {
        self.product = product
        self.imageRatio = imageRatio
        self.descriptionFontSize = descriptionFontSize
    }
    
    var priceWithCurrency:String {
        return "\(product.price.value)\(product.price.currency)"
    }
    
    var oldAttributedPriceText:NSAttributedString? {
        
        if let oldPrice = product.old_price {
            
            let originalPriceAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),
                NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
            ]
            let originalPriceString = NSAttributedString(string: "\(oldPrice.value)\(oldPrice.currency)", attributes: originalPriceAttributes)
            
            return originalPriceString
            
        }else{
            return nil
        }
        
    }
}
