//
//  ProductRateView.swift
//  CaseStudy
//
//  Created by Ömer Demir on 28.11.2022.
//

import UIKit

class ProductRateView: UIView {
    
    @IBOutlet weak var rateStackView: UIStackView!
    
    var rate:Double = 0.0{
        didSet {
            setOutlets()
        }
    }
    
    
    //Main
    override func awakeFromNib() {
        super.awakeFromNib()
        setOutlets()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit (){
        let view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor.clear
        backgroundColor = .clear
        addSubview(view)
        clipsToBounds = true
    }
    
    private func loadViewFromNib() -> UIView{
        let bundle =  Bundle(for: self.classForCoder)
        return UINib(nibName: "ProductRateView", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setOutlets()
    }
    
    private func setOutlets(){
        let rating = rate / 20.0
        
        for i in 0..<rateStackView.subviews.count {
            if let starImageView = rateStackView.subviews[i] as? UIImageView {
                
                starImageView.image = UIImage(named: "star")
                
                let doubleI = Double(i) + 1.0
                if doubleI <= rating  {
                    starImageView.tintColor = UIColor.xGreen
                } else {
                    let decimal = rating - doubleI + 1.0
                    
                    if decimal > 0, decimal < 1, starImageView.image != nil{
                        starImageView.image = getColorodStar(image: starImageView.image!, maincolor: UIColor.xGreen, secondColor: UIColor.xGray, decimal: decimal)
                    }else{
                        starImageView.tintColor = UIColor.xGray
                    }
                }
            }
        }
        
    }
    
    private func getColorodStar(image: UIImage, maincolor: UIColor, secondColor: UIColor, decimal:Double) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: rect)
        
        //maincolor
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        context.setFillColor(maincolor.cgColor)
        
        let orangeWidth = image.size.width * CGFloat(decimal)
        let rectToFill = CGRect(x: 0, y: 0, width: orangeWidth, height: image.size.height)
        context.fill(rectToFill)
        
        
        //secondColor
        let context2 = UIGraphicsGetCurrentContext()!
        context2.setBlendMode(CGBlendMode.sourceIn)
        context2.setFillColor(secondColor.cgColor)
        
        let grayWidth = image.size.width - orangeWidth
        let rectToFill2 = CGRect(x: orangeWidth, y: 0, width: grayWidth, height: image.size.height)
        context2.fill(rectToFill2)
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
