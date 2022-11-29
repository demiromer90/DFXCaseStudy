//
//  ProductCollectionViewCell.swift
//  CaseStudy
//
//  Created by Ömer Demir on 28.11.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let defaultReuseIdentifier = "ProductCell"
    
    @IBOutlet weak var shadowView:UIView!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet var imageViewRatioConstraint:NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel:UILabel!
    
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var oldPriceLabel:UILabel!
    @IBOutlet weak var discountLabel:UILabel!
    
    @IBOutlet weak var rateView:ProductRateView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.cornerRadius = 4
        shadowView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowView.layer.shadowRadius = 2.0
        shadowView.layer.shadowOpacity = 0.3
    }
    
    func configureWith(productVM:ProductCellVM) {
        if imageView != nil {
            imageView.removeConstraint(imageViewRatioConstraint)
            imageViewRatioConstraint = NSLayoutConstraint(item: imageView!, attribute: .width, relatedBy: .equal, toItem: imageView!, attribute: .height, multiplier: productVM.imageRatio, constant: 0)
            imageView.addConstraint(imageViewRatioConstraint!)
        }
        imageView.imageFromUrl(urlString: productVM.product.imageUrl, placeHolderImage: nil)
        
        
        descriptionLabel.font = UIFont.systemFont(ofSize: productVM.descriptionFontSize)
        descriptionLabel.text = productVM.product.desc
        
        //Price
        priceLabel.text = productVM.priceWithCurrency
        
        if let oldAtributedPrice = productVM.oldAttributedPriceText {
            priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            oldPriceLabel.superview?.isHidden = false
            oldPriceLabel.attributedText = oldAtributedPrice
            
            discountLabel.text = productVM.product.discount
        }else{
            priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
            oldPriceLabel.superview?.isHidden = true
        }
        
        //Rate
        if let rate = productVM.product.rate_percentage, rate > 0 {
            rateView.isHidden = false
            rateView.rate = rate
        }else{
            rateView.isHidden = true
        }
        
    }
}
