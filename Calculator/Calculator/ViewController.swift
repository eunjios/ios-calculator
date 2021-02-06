//
//  ViewController.swift
//  Calculator
//
//  Created by 이은지 on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {
    var valueArr = [0]
    var isSum = false
    var isSub = false
    var inputNum = 0
    var temp = 0
    
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var sumButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background color
        self.view.backgroundColor = UIColor.black
    }
    
    // 고민 1. numberNButton 모두 다 같은 기능을 수행함
    // --> 어떻게 코드를 간단하게 할지
    // --> valueArr.append(~~.text) 로만 바꾸면 아예 동일함
    // --> custombutton 처럼 하나로 어떻게 만들지
    @IBAction func number0Button(_ sender: Any) {
        valueArr.append(0)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }

    @IBAction func number1Button(_ sender: Any) {
        valueArr.append(1)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number2Button(_ sender: Any) {
        valueArr.append(2)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number3Button(_ sender: Any) {
        valueArr.append(3)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number4Button(_ sender: Any) {
        valueArr.append(4)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number5Button(_ sender: Any) {
        valueArr.append(5)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number6Button(_ sender: Any) {
        valueArr.append(6)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number7Button(_ sender: Any) {
        valueArr.append(7)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number8Button(_ sender: Any) {
        valueArr.append(8)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number9Button(_ sender: Any) {
        valueArr.append(9)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    // Operator
    @IBAction func acButton(_ sender: Any) {
        temp = 0
        valueArr = del(valueArr)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func pmButton(_ sender: Any) {
        inputNum = -inputNum
        currentValueLabel.text = String(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func sumButton(_ sender: UIButton) {
        inputNum = Int(currentValueLabel.text ?? "0")!
        isSum = true
        
        if isSub {
            temp -= inputNum
            isSub = false
        } else {
            temp += inputNum
        }
        
        currentValueLabel.text = String(temp)
        valueArr = del(valueArr)
        sumButton.isUserInteractionEnabled = false
    }
    
    @IBAction func subButton(_ sender: UIButton) {
        inputNum = Int(currentValueLabel.text ?? "0")!
        isSub = true
        
        if isSum {
            temp += inputNum
            isSum = false
        } else {
            temp -= inputNum
        }

        currentValueLabel.text = String(temp)
        valueArr = del(valueArr)
        subButton.isUserInteractionEnabled = false
    }
    
    @IBAction func equalButton(_ sender: Any) {
        inputNum = Int(currentValueLabel.text ?? "0")!
        if isSum {
            temp += inputNum
        } else if isSub {
            temp -= inputNum
        }
        currentValueLabel.text = String(temp)
    }

}

func enableButtons(_ button1: UIButton!, _ button2: UIButton!) {
    button1.isUserInteractionEnabled = true
    button2.isUserInteractionEnabled = true
}

// update current value
func updateValue(_ arr: [Int]) -> Int {
    let arrayToString = arr.map{String($0)}.joined()
    return Int(arrayToString) ?? 0
}

// update current label text
func updateLabel(_ value: Int, _ label: UILabel) {
    return label.text = String(value)
}

// delete current value
func del(_ arr: [Int]) -> [Int] {
    var result = [Int]()
    result.append(0)
    return result
}
