//
//  InfoTask.swift
//  OtsimoTest
//
//  Created by demirci on 16/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit


func createTextChoices(choices : [String]) -> [ORKTextChoice]{
    var textChoices : [ORKTextChoice] = []
    
    var i = 1
    for c in choices{
        print(i)
        let t = ORKTextChoice(text: c, value: i as NSCoding & NSCopying & NSObjectProtocol)
        textChoices.append(t)
        i += 1
    }
    
    return textChoices
}

//ids
let relationStepID = "relation"
let genderStepID = "gender"
let ageStepID = "age"

public var InfoTask: ORKOrderedTask {
    
   
    var infosteps = [ORKStep]()

    let relationStep = { () -> ORKQuestionStep in 
        
        let relations = ["Parent","GrandParent","Guardion","Educator","Healt care provider","other"]
        
        let textChoices = createTextChoices(choices: relations)
        
        let relationStep = ORKQuestionStep(identifier: relationStepID, title: "What is your relationship to the child?", answer: ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices))
        return relationStep
    }
    infosteps.append(relationStep())
    
    let genderStep = { () -> ORKQuestionStep in
        
        let gender = ["male","female"]
        
        let textChoices = createTextChoices(choices: gender)
    
        let genderStep = ORKQuestionStep(identifier: genderStepID, title: "What is gender of child? ", answer: ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices))
        return genderStep
        
    }
    infosteps.append(genderStep())
    
    
    let ageStep = { () -> ORKQuestionStep in 
        let ageStep =  ORKQuestionStep(identifier: ageStepID, title: "How old are the child?", answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "Years"))
        return ageStep
    }
    infosteps.append(ageStep())

    return ORKOrderedTask(identifier: "InfoTask", steps: infosteps)


}
