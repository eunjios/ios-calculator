//
//  CustomButton.swift
//  Calculator
//
//  Created by 이은지 on 2021/02/07.
//

import UIKit

class NumberBaseButton: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 42
//        if isSelected {
//            self.layer.backgroundColor = UIColor.systemGray3.cgColor
//        } else {
//            self.layer.backgroundColor = UIColor.darkGray.cgColor
//        }
        
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        self.setTitleColor(.white, for: .normal)
        
    }
//    override var isHighlighted: Bool {
//        didSet {
//            backgroundColor =  isHighlighted ? UIColor.gray : UIColor.darkGray
//        }
//    }
//    override var isSelected: Bool {
//        didSet {
//            backgroundColor = isSelected ? UIColor.gray : UIColor.white
//            setNeedsDisplay()
//        }
//    }
    
}

class OperatorBaseButton: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 42
//        if self.isEnabled {
//
//        }
        self.layer.backgroundColor = UIColor.systemOrange.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.systemOrange, for: .disabled)
    }
}

class SpecialOperatorBaseButton: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 42
        self.layer.backgroundColor = UIColor.systemGray3.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        self.setTitleColor(.black, for: .normal)
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}


