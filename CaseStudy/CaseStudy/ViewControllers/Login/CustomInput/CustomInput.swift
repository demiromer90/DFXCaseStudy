//
//  CustomInput.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import UIKit

@IBDesignable
class CustomInput: UIView {
    
    //Outlets
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
    //IBInspectable
    @IBInspectable var placeHolder: String = ""
    
    @IBInspectable var secureText: Bool = false
    
    @IBInspectable var lineColor: UIColor = UIColor.xGray
    
    @IBInspectable var image: UIImage?
    
    
    //Main
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
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
        addSubview(view)
        clipsToBounds = true
        textField.delegate = self
    }
    
    private func loadViewFromNib() -> UIView{
        let bundle =  Bundle(for: self.classForCoder)
        return UINib(nibName: "CustomInput", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setOutlets()
    }
    
    private func setOutlets(){
        
        placeholderLabel.text = placeHolder.localized()
        textField.isSecureTextEntry = secureText
        lineView.backgroundColor = lineColor
        rightImageView.image = image
        
    }
    
    //Setter - Getter
    func setText(text: String){
        textField.text = text
        textFieldDidChange(textField)
    }
    
    func text() -> String{
        return textField.text ?? ""
    }
    
    
    //Validation
    enum InputState {
        case normal, success, fail, focus
    }
    
    func setState(state:InputState) {
        switch state {
        case .normal:
            placeholderLabel.textColor = UIColor.xGray
            lineView.backgroundColor = UIColor.xGray
            
        case .success:
            placeholderLabel.textColor = UIColor.xGray
            lineView.backgroundColor = UIColor.xGreen
            
        case .fail:
            placeholderLabel.textColor = UIColor.xRed
            lineView.backgroundColor = UIColor.xRed
            
        case .focus:
            placeholderLabel.textColor = UIColor.xGray
            lineView.backgroundColor = UIColor.xBlue
            
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension CustomInput:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setState(state: .focus)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setState(state: .normal)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty, placeholderLabelCenterY.constant == 0 {
            placeholderLabelCenterY.constant = -((textField.frame.size.height/2.0)+5)
            placeholderLabel.font = UIFont.systemFont(ofSize: 12)
            UIView.animate(withDuration: 0.1) {
                self.layoutIfNeeded()
            }
        }else if let text = textField.text, text.isEmpty, placeholderLabelCenterY.constant != 0{
            placeholderLabelCenterY.constant = 0
            placeholderLabel.font = UIFont.systemFont(ofSize: 16)
            UIView.animate(withDuration: 0.1) {
                self.layoutIfNeeded()
            }
        }
    }
    
}

