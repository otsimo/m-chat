//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let now = Date.init()
let month1 = 730001 * 3600
let month30 = 77760000
let month16 = 15552000
let month30From1970 = Int(now.timeIntervalSince1970) - month30
let month16From1970 = Int(now.timeIntervalSince1970) - month16
print(now)