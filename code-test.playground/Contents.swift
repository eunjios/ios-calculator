import UIKit

/*
 ----- Introduction
 처음에는 calculator 의 모든 연산을 Int type 으로 했지만,
 나누기, 소수점 등의 새로운 기능들을 추가하면서 Int type이 아닌 Double type이 필요함
 그래서 내 생각과 동일하게 작동하는지 작성해본 테스트 코드
 */

let intNum = 3
let doubleNum1 = 3.0
let doubleNum2 = 6.0

/* ----- Test
 간단한 type casting test
 */

let intToDouble = Double(intNum)
let doubleToInt = Int(doubleNum2)
print(intToDouble)                  // 3.0 출력
print(doubleToInt)                  // 6 출력


/* ----- Function 1
 아이폰 계산기의 경우 출력되는 type 이 고정이 되어있지 않음.
 [case 1] 연산 결과의 소수 부분을 무시할 수 있으면 -> Int 로 결과 출력
    ex) 3.0 + 7.0 = 10.0 -> 10 출력
 [case 2] 연산 결과의 소수 부분을 무시할 수 없으면 -> Double 로 결과 출력
    ex) 3.1 + 7.0 = 10.1 -> 10.1 출력
 */

/* ----- Solution 1
 나누기 (연산) 결과가 나누어 떨어지는지에 따라 type 변환
 [case 1] 나머지가 0 이면 -> Int 로 결과 출력
 [case 2] 나머지가 0이 아니면 -> Double 로 결과 출력
 */
if doubleNum1.truncatingRemainder(dividingBy: doubleNum2) == 0 {
    print(Int(doubleNum1 / doubleNum2))
} else {
    print(doubleNum1 / doubleNum2)
}

/* ----- Solution 2
 solution 1 의 문제점: 나누기가 아니어도 연산 결과가 Double type 일 수 있다.
 따라서 특정 연산이 아닌 모든 연산에 공통으로 적용할 수 있는 방식이 필요
 [case 1] 연산 결과에 연산 결과의 정수 부분을 뺀 것이 0 이면 -> Int 로 결과 출력
 [case 2] 연산 결과에 연산 결과의 정수 부분을 뺀 것이 0 이 아니면 -> Double 로 결과 출력
 */
if doubleNum1 + doubleNum2 - Double(Int(doubleNum1 + doubleNum2)) == 0 {
    // 정수로 출력
    print(Int(doubleNum1 + doubleNum2))
} else {
    // double 로 출력
    print(doubleNum1 + doubleNum2)
}


/* ----- Function 2
 계산기의 경우 소수점 (.) 를 직접 추가하여 소수를 만들 수 있음
 */
/* ----- Solution
 모든 사용자의 입력을 String type 의 배열로 추가한 후,
 1. 배열 -> String 으로 변경
 2. String 으로 변경된 것을 Double 타입으로 변경
 */
let charArr = ["1", "2", ".", "3"]
let arrToStirng = charArr.map{String($0)}.joined()
print(Double(arrToStirng) ?? 0.0)
