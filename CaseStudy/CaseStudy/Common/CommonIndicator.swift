//
//  CommonIndicator.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import UIKit


class CommonIndicator: UIImageView {
    
    weak var topView:UIView?
    
    private var blackBackground:UIView = {
        let bb = UIView()
        bb.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return bb
    }()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        clipsToBounds = true
        layer.cornerRadius = frame.size.height/2.0
        backgroundColor = UIColor.clear
        
        var animationImageList:[UIImage] = []
        for i in 1..<20 {
            animationImageList.append(UIImage(named: "indicatorGift\(i)")!)
        }
        animationImages = animationImageList
        animationDuration = 1.0
        animationRepeatCount = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimatingOnView(view:UIView) -> Void {
        topView?.isUserInteractionEnabled = true
        topView = view
        view.isUserInteractionEnabled = false
        
        let height = view.bounds.size.height
        let width = view.bounds.size.width
        let center = CGPoint(x: width/2.0, y: height/2.0)
        self.center = center
        
        blackBackground.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        blackBackground.alpha = 0.0
        alpha = 0.0
        
        blackBackground.removeFromSuperview()
        removeFromSuperview()
        view.addSubview(blackBackground)
        view.addSubview(self)
        
        startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.blackBackground.alpha = 1.0
            self.alpha = 1.0
        }
    }
    
    override func stopAnimating() {
        super.stopAnimating()
        topView?.isUserInteractionEnabled = true
        if (superview != nil) {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0.0
                self.blackBackground.alpha = 0.0
            }, completion: { finished in
                self.removeFromSuperview()
                self.blackBackground.removeFromSuperview()
            })
        }
    }
    
}
