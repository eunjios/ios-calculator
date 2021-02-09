//
//  ViewController.swift
//  Calculator
//
//  Created by 이은지 on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {
    // 입력, 입력 취소가 편하게 하려고 배열로 입력 받음.
    var valueArr = [0]
    var inputNum = 0
    var temp = 0        // 화면에 보여지는 값 (중간 계산 과정)
    var result = 0      // 실제 연산 결과
    
    // 과거 상태와 현재 상태 따로 저장
    var pastState = ""
    var presentState = "" // sum, sub, multi, div, ac, pm, percent
    
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
        result = 0
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
        // 과거 상태와 현재 상태 update
        pastState = presentState
        presentState = "sum"
        
        // inputNum에 현재 화면에 보이는 Label 값 할당
        inputNum = Int(currentValueLabel.text ?? "0")!
        
        // 과거 상태의 연산으로 temp 값 설정
        temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        
        // 과거 상태가 곱하기나 나누기면, result에 temp 값을 더함
        // 과거 상태가 더하기나 빼기면, result에 inputNum 값을 연산
        if pastState == "multi" || pastState == "div" {
            result = calculateTwoNumbers(state: "sum", num1: result, num2: temp)
        } else {        // sum or sub
            result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
        }
        
        // 덧셈 뺄셈의 경우는 result 를 바로 출력한다.
        currentValueLabel.text = String(result)
        valueArr = del(valueArr)
        sumButton.isUserInteractionEnabled = false
    }
    
    @IBAction func subButton(_ sender: UIButton) {
        pastState = presentState
        presentState = "sub"
        inputNum = Int(currentValueLabel.text ?? "0")!

        temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        
        if pastState == "multi" || pastState == "div" {
            result = calculateTwoNumbers(state: "sum", num1: result, num2: temp)
        } else {        // sum or sub
            result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
        }

        currentValueLabel.text = String(result)
        valueArr = del(valueArr)
        subButton.isUserInteractionEnabled = false
    }
    
    @IBAction func multiButton(_ sender: UIButton) {
        pastState = presentState
        presentState = "multi"
        inputNum = Int(currentValueLabel.text ?? "0")!
        
        // 과거 상태가 sum 이면 현재 inputNum 을 temp 에 할당
        // 과거 상태가 sub 이면 현재 inputNum 에 - 취한 값을 할당
        // 과거 상태가 곱하기나 나누기면 과거 연산을 수행하여 temp 값에 할당
        if pastState == "sum" {
            temp = inputNum
        } else if pastState == "sub" {
            temp = -inputNum
        } else {
            temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        }
        
        // 곱셈 나눗셈의 경우 중간 연산 과정 (temp) 을 출력한다.
        currentValueLabel.text = String(temp < 0 ? -temp : temp)
        valueArr = del(valueArr)
        subButton.isUserInteractionEnabled = false
    }
    
    @IBAction func equalButton(_ sender: Any) {
        currentValueLabel.text = String(calculateTwoNumbers(state: presentState, num1: result, num2: inputNum))
    }

}


func calculateTwoNumbers(state: String, num1: Int, num2: Int) -> Int {
    var result = 0
    
    switch state {
    //case "input":
        // 숫자 입력 코드
    case "sum":
        result = num1 + num2
    case "sub":
        result = num1 - num2
    case "multi":
        result = num1 * num2
    case "div":
        result = num1 / num2
    default:
        result = num2
    }
    return result
}

func calculateANumber(state: String, num: Int) -> Int {
    var result = 0

    switch state {
    case "ac":
        result = 0
    case "pm":
        result = -num
    case "percent":
        result = num / 100
    default:
        result = 0
    }
    return result
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
