//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

////Monday////
////Code Challenge: Write a function that determines how many words there are in a sentence
func countingWords(counting: NSString) -> (Int) {
var arr = counting.componentsSeparatedByString(" ")
var numberResult = arr.count
  return numberResult
}

let wordCount = countingWords("I will take the Ring to Mordor!")

////Tuesday////
////Code Challenge: Write a function that returns all the odd elements of an array

var iCantEven : [Int] = [1, 2, 3, 4, 5]

func oddReturn(list : [Int]) -> [Int] {
for i in list {
  if (i % 2) == 0 {
    println(" ")
  } else {
    println(i)
  }
}
}
let oddResult = oddReturn(iCantEven)


////Wednesday////
////Code Challenge: Write a function that computes the list of the first 100 Fibonacci numbers.




func fibonacciSequence(number: Int) -> Int {
  if (number == 0) {
    return 0
  }
else if (number == 1) {
  return 1
}
return fibonacciSequence(number - 1) + fibonacciSequence(number - 2)
}
let result = fibonacciSequence(10)

println(result)

//var number : Int
//
//let sequence = GeneratorSequence(fibonacciSequence(number))
//for n in sequence {
//  if (n > 90) {
//    break
//  }
//  print("\(n), ")
//}


////Thursday////
////Code Challenge: Write a function that tests whether a string is a palindrome


var word : String = "anna"
func isPalindrome(sentence : String) -> Boolean {
  var charactersInString = sentence.componentsSeparatedByString("")
  var countingString : Int = charactersInString.count
  for i in charactersInString {
    if (i == (countingString - i)) {
      return true
    } else {
      return false
    }
    
  }
}











