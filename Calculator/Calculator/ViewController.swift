//
//  ViewController.swift
//  Calculator
//
//  Created by 이은지 on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
    }


}

class NumberBaseButton: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 42
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        self.setTitleColor(.white, for: .normal)
    }
}

class OperatorBaseButton: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 42
        self.layer.backgroundColor = UIColor.systemOrange.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        self.setTitleColor(.white, for: .normal)
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

