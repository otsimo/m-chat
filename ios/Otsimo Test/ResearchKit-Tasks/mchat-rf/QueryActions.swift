//
//  QueryActions.swift
//  OtsimoTest
//
//  Created by demirci on 14/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


func AllOfYes(groupAnswers: [GroupAnswer]) -> Bool {

    let aa = groupAnswers.filter { (ga) -> Bool in
        return !ga.answer
    }
    return aa.count == 0
}
func AllOfNo(groupAnswers: [GroupAnswer]) -> Bool {
    let aa = groupAnswers.filter { (ga) -> Bool in
        return ga.answer
    }
    return aa.count == 0
}
func MostOftenYesNo(groupAnswers: [GroupAnswer],checkYes:Bool) -> Bool {
    var yes = 0
    var no = 0
    
    for answer in groupAnswers{
        if answer.answer{
            yes += 1
        }else if answer.answer{
            no += 1
        }
    }
    if checkYes{
        return  yes > no
    }
    return no > yes
}
func oneOfNo(groupAnswers: [GroupAnswer]) -> Bool {
   
    for ga in groupAnswers{
        if !ga.answer{
            return true
        }
    }
    return false
}
func oneOfYes(groupAnswers: [GroupAnswer]) -> Bool {
    
    for ga in groupAnswers{
        if ga.answer{
            return true
        }
    }
    return false
}

func twoOrMoreYes(groupAnswers: [GroupAnswer]) -> Bool {
    var yes = 0
    for ga in groupAnswers{
        if ga.answer{
            yes += 1
        }
    }
    
    return yes >= 2
}

