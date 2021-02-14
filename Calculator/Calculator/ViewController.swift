//
//  ViewController.swift
//  Calculator
//
//  Created by 이은지 on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {
    var valueArr = ["0"]  // 입력, 입력 취소가 편하게 하려고 배열로 입력 받음.
    var inputNum = 0.0    // 처음 입력된 수를 0으로 설정
    var temp = 0.0        // 화면에 보여지는 값 (중간 계산 과정)
    var result = 0.0      // 실제 연산 결과
    
    // 과거 상태와 현재 상태 따로 저장
    var pastState = ""
    var presentState = ""       // sum, sub, multi, div, eq
    var beforeMultiState = ""   // 곱하기나 나누기 전에 + 인지 - 인지를 저장하는 값
    
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
    // --> 일단 기능부터 되는지 구현하고 나중에 코드 정리하자...
    @IBAction func number0Button(_ sender: Any) {
        valueArr.append("0")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }

    @IBAction func number1Button(_ sender: Any) {
        valueArr.append("1")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number2Button(_ sender: Any) {
        valueArr.append("2")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number3Button(_ sender: Any) {
        valueArr.append("3")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number4Button(_ sender: Any) {
        valueArr.append("4")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number5Button(_ sender: Any) {
        valueArr.append("5")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number6Button(_ sender: Any) {
        valueArr.append("6")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number7Button(_ sender: Any) {
        valueArr.append("7")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number8Button(_ sender: Any) {
        valueArr.append("8")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func number9Button(_ sender: Any) {
        valueArr.append("9")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func dotButton(_ sender: Any) {
        valueArr.append(".")
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    // Operator
    @IBAction func acButton(_ sender: Any) {
        pastState = ""
        presentState = ""
        beforeMultiState = ""
        temp = 0.0
        result = 0.0
        valueArr = del(valueArr)
        inputNum = updateValue(valueArr)
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func pmButton(_ sender: Any) {
        inputNum = -inputNum
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func percentButton(_ sender: Any) {
        inputNum = inputNum / 100
        currentValueLabel.text = intOrDouble(inputNum)
        enableButtons(sumButton, subButton)
    }
    
    @IBAction func sumButton(_ sender: UIButton) {
        // 과거 상태와 현재 상태 update
        pastState = presentState
        presentState = "sum"
        
        // inputNum에 현재 화면에 보이는 Label 값 할당
        inputNum = Double(currentValueLabel.text ?? "0")!
        
        // 과거 상태의 연산으로 temp 값 설정
        temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        
        // 과거 상태가 곱하기나 나누기면, result에 temp 값을 더하거나 뺌
        // 과거 상태가 더하기나 빼기면, result에 inputNum 값을 연산
        if pastState == "multi" || pastState == "div" {
            if beforeMultiState == "" {
                result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
            } else {
                result = calculateTwoNumbers(state: beforeMultiState, num1: result, num2: temp)
            }
//            if beforeMultiState == "sum" {
//                result = calculateTwoNumbers(state: "sum", num1: result, num2: temp)
//            } else if beforeMultiState == "sub" {
//                result = calculateTwoNumbers(state: "sub", num1: result, num2: temp)
//            }
        } else {        // sum or sub
            result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
        }
        
        // 덧셈 뺄셈의 경우는 result 를 바로 출력한다.
        currentValueLabel.text = intOrDouble(result)
        valueArr = del(valueArr)
        sumButton.isUserInteractionEnabled = false
        beforeMultiState = "sum"
    }
    
    @IBAction func subButton(_ sender: UIButton) {
        pastState = presentState
        presentState = "sub"
        inputNum = Double(currentValueLabel.text ?? "0")!

        temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        
        if pastState == "multi" || pastState == "div" {
            if beforeMultiState == "" {
                result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
            } else {
                result = calculateTwoNumbers(state: beforeMultiState, num1: result, num2: temp)
            }
        } else {        // sum or sub
            result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
        }
        
        currentValueLabel.text = intOrDouble(result)
        valueArr = del(valueArr)
        subButton.isUserInteractionEnabled = false
        beforeMultiState = "sub"
    }
    
    @IBAction func multiButton(_ sender: UIButton) {
        pastState = presentState
        presentState = "multi"
        inputNum = Double(currentValueLabel.text ?? "0")!
        
        // 과거 상태가 sum 이면 현재 inputNum 을 temp 에 할당
        // 과거 상태가 sub 이면 현재 inputNum 에 - 취한 값을 할당
        // 과거 상태가 곱하기나 나누기면 과거 연산을 수행하여 temp 값에 할당
        if pastState == "multi" || pastState == "div" {
            temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        } else /*if pastState == "sum" || pastState == "sub" || pastState == "eq" || pastState == ""*/{
            temp = inputNum
        }
        
        // 곱셈 나눗셈의 경우 중간 연산 과정 (temp) 을 출력한다.
        currentValueLabel.text = intOrDouble(temp)
        valueArr = del(valueArr)
        subButton.isUserInteractionEnabled = false
    }
    
    @IBAction func divButton(_ sender: UIButton) {
        pastState = presentState
        presentState = "div"
        inputNum = Double(currentValueLabel.text ?? "0")!
        
        if pastState == "multi" || pastState == "div" {
            temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
        } else /* if pastState == "sum" || pastState == "sub" || pastState == "eq" || pastState == "" */ {
            temp = inputNum
        }
        currentValueLabel.text = intOrDouble(temp)
        valueArr = del(valueArr)
        subButton.isUserInteractionEnabled = false
    }
    
    @IBAction func equalButton(_ sender: Any) {
        temp = calculateTwoNumbers(state: presentState, num1: temp, num2: inputNum)
        
        if pastState == "" {
            currentValueLabel.text = intOrDouble(temp)
        } else {
            if presentState == "multi" || presentState == "div" {
                if beforeMultiState == "" {
                    result = temp
                } else {
                    result = calculateTwoNumbers(state: beforeMultiState, num1: result, num2: temp)
                }
            } else {
                result = calculateTwoNumbers(state: presentState, num1: result, num2: inputNum)
            }
            currentValueLabel.text = intOrDouble(result)
        }
        presentState = "eq"
        beforeMultiState = ""
    }
}

// Functions
// calculate two numbers
func calculateTwoNumbers(state: String, num1: Double, num2: Double) -> Double {
    var result = 0.0
    
    switch state {
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

// return int type string or double type string
func intOrDouble(_ value: Double) -> String {
    let roundedValue = round(value * 1000000000) / 1000000000   // trouble shooting
    if roundedValue - Double(Int(roundedValue)) == 0 {
        return String(Int(roundedValue))
    } else {
        return String(roundedValue)
    }
}

// update current value
func updateValue(_ arr: [String]) -> Double {
    let arrayToString = arr.map{String($0)}.joined()
    return Double(arrayToString) ?? 0.0
}

// reset input value
func del(_ arr: [String]) -> [String] {
    var result = [String]()
    result.append("0")
    return result
}

func enableButtons(_ button1: UIButton!, _ button2: UIButton!) {
    button1.isUserInteractionEnabled = true
    button2.isUserInteractionEnabled = true
}
