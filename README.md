# :iphone: iOS Calculator
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
<br><br>

## :gear: Development Environment
* Xcode 12.3
* Swift 5

