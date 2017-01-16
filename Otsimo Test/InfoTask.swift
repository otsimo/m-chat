//
//  InfoTask.swift
//  OtsimoTest
//
//  Created by demirci on 16/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit



public var InfoTask: ORKOrderedTask {
   
    var infosteps = [ORKStep]()

    let relationStep = { () -> ORKQuestionStep in 
        
        var relations = ["Parent","GrandParent","Guardion","Educator","Healt care provider","other"]
        
        var textChoices : [ORKTextChoice] = []
        
        var i = 1
        for r in relations{
            print(i)
            let t = ORKTextChoice(text: r, value: i as NSCoding & NSCopying & NSObjectProtocol)
            textChoices.append(t)
            i += 1
        }
        
        let relationStep = ORKQuestionStep(identifier: "relation", title: "What is your relationship to the child?", answer: ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices))
        return relationStep
    }
    infosteps.append(relationStep())
    
    let ageStep = { () -> ORKQuestionStep in 
        let ageStep =  ORKQuestionStep(identifier: "age", title: "How old are your child?", answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "Years"))
        return ageStep
    }
    infosteps.append(ageStep())

    return ORKOrderedTask(identifier: "InfoTask", steps: infosteps)


}
