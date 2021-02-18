# :iphone: iOS Calculator
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Feunjios%2Fios-calculator&count_bg=%23C8963D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
![GitHub all releases](https://img.shields.io/github/downloads/eunjios/ios-calculator/total) ![GitHub last commit](https://img.shields.io/github/last-commit/eunjios/ios-calculator)

> 아직 미완성인 프로젝트 입니다. 

![ios-calculator-simulator](https://user-images.githubusercontent.com/77034159/107759089-284d1280-6d6b-11eb-9fef-9e900b6d2261.gif)

## :pushpin: Introduction
iPhone에 내장되어 있는 계산기와 기능 및 디자인을 동일하게 만든 iOS 앱 입니다.  
<br><br>
## :triangular_ruler: Functionality
### 1. 기본적인 연산 기능
기본적인 연산 (+, −, ×, ÷) 이 가능합니다.

![](https://user-images.githubusercontent.com/77034159/107869918-05d80800-6ed7-11eb-8470-e282013fcec2.gif)
<br><br>

### 2. 결과 출력
   * 출력값을 `Int` type 으로 변환해도 상관 없는 경우, `Int` type 으로 출력 결과를 반환합니다.  
     그러나 그렇지 않은 경우는 `Double` type 으로 출력합니다.
     
![](https://user-images.githubusercontent.com/77034159/107870031-497f4180-6ed8-11eb-9ec8-f5a63c59b74a.gif)

   * **+, − 연산**은 전체 식의 `result` 값을 화면에 출력
     
![](https://user-images.githubusercontent.com/77034159/107870155-a0d1e180-6ed9-11eb-9abe-5ad0df450207.gif)


   * **×, ÷ 연산**은 해당 연산의 결과값인 `temp` 만 출력

![](https://user-images.githubusercontent.com/77034159/107870516-6453b500-6edc-11eb-8645-4727b353719e.gif)

<br><br>
## :hammer: Trouble Shooting
### 1. 곱하기 나누기 연산이 제대로 안되는 오류 
<u>**문제 인식**</u>
* 연산 결과가 예상과는 다르게 Int type 으로 변환이 안되고 `0.2000...` 과 같이 너무 길게 출력
* Double type 을 입력 받은 후 곱하기, 나누기 연산을 하면, 결과값이 다르게 나오는 상황 발생
* Swift 자체의 연산 결과가 틀림
  
     ``` swift
     print(3.3 * 3)  
     // 9.89999999... 출력
     ```

<u>**Solution**</u>
* `round()` 를 사용하여 소수점 아래 N번째 숫자에서 반올림 하도록 코드 작성
  
     ``` swift
    print(round(3.3 * 3 * 1000) / 1000)
    // 9.9 출력
    ```
  
* 해당 function 수정
     ```swift
    func intOrDouble(_ value: Double) -> String {
          let roundedValue = round(value * 1000000000) / 1000000000
          if roundedValue - Double(Int(roundedValue)) == 0 {
               return String(Int(roundedValue))
          } else {
               return String(roundedValue)
          }
     }
     ```
     
### 2. 곱셈/나눗셈에서 덧셈/뺄셈 연산을 하는 경우에 대해 화면에서 0이 출력되는 오류 발생
<u>**문제 상황**</u>

* 앱을 시작하고 첫 연산이 곱셈인 경우에 대해 이후 덧셈을 할 경우 결과가 0으로 출력되는 오류 발생
* 예를 들어보자.


```swift
10 * 10 * 10 + 10 을 계산하면 + 버튼을 누름과 동시에 화면에 0 이 출력됨
```

<u>**문제 인식**</u>

* `+` 또는 `-` 버튼을 누름과 동시에 이상한 결과가 출력되므로 해당 `@IBAction func` 에 문제가 있음을 인식
* 첫 연산이 곱셈/나눗셈인 경우에만 이 오류가 발생하기 때문에 이전 연산이 없는 경우에 대해 문제가 있음을 인식 


아래 코드는 기존 `@IBAction func sumButton` 의 일부이다.

```swift
...
// 과거 상태가 곱하기나 나누기면, result에 temp 값을 더하거나 뺌
// 과거 상태가 더하기나 빼기면, result에 inputNum 값을 연산
if pastState == "multi" || pastState == "div" {
    if beforeMultiState == "" {
        result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)  // error
    } else {
        result = calculateTwoNumbers(state: beforeMultiState, num1: result, num2: temp)
    }
} else {        // sum or sub
    result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
}
...
```
    
* **`temp` 란?** 연산의 임시 결과값으로 `=` 을 누르기 전까지 화면에 보이는 값을 의미
* **`result` 란?** 현재의 최종 결과값으로 현재 상태가 `sum` 이나 `sub` 일 때만 계산하여 값을 바꿈 
* **`beforeMultiState` 란?** 곱셈/나눗셈 전 상태가 덧셈이었는지 뺄셈이었는지 알기 위해 만든 변수로 초기값은 `""` 이며, `result` 값을 구하기 위해 사용됨


문제가 되는 부분: `result(=0)` 와 `inputNum` 을 `pastState(곱셉/나눗셈)` 으로 계산하기 때문에 0 이 나올 수밖에 없음

<u>**Solution**</u>

* 해당 function 수정
```swift
...
if pastState == "multi" || pastState == "div" {
    if beforeMultiState == "" {
        result = temp   // temp = calculateTwoNumbers(state: pastState, num1: temp, num2: inputNum)
    } else {
        result = calculateTwoNumbers(state: beforeMultiState, num1: result, num2: temp)
    }
} else {                // sum or sub
    result = calculateTwoNumbers(state: pastState, num1: result, num2: inputNum)
}
...
```
<br><br>

## :gear: Development Environment
* Xcode 12.3
* Swift 5

