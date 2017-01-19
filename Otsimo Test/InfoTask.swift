//
//  InfoTask.swift
//  OtsimoTest
//
//  Created by demirci on 16/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit


func createTextChoices(choices: [String]) -> [ORKTextChoice] {
    var textChoices: [ORKTextChoice] = []

    var i = 1
    for c in choices {
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

        let relations = [ NSLocalizedString("InfoTask.relations.Parent", comment: ""),
            NSLocalizedString("InfoTask.relations.GrandParent", comment: ""),
            NSLocalizedString("InfoTask.relations.Guardion", comment: ""),
            NSLocalizedString("InfoTask.relations.Educator", comment: ""),
            NSLocalizedString("InfoTask.relations.HealtCareProvider", comment: ""),
            NSLocalizedString("InfoTask.relations.other", comment: "")
        ]

        let textChoices = createTextChoices(choices: relations)

        let relationStepText = NSLocalizedString("InfoTask.relationStepText", comment: "")
        let relationStep = ORKQuestionStep(identifier: relationStepID, title: relationStepText, answer: ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices))
        return relationStep
    }
    infosteps.append(relationStep())

    let genderStep = { () -> ORKQuestionStep in

        let gender = [NSLocalizedString("InfoTask.gender.Male", comment: ""),
                      NSLocalizedString("InfoTask.gender.Female", comment: "")]

        let textChoices = createTextChoices(choices: gender)
        let genderStepText = NSLocalizedString("InfoTask.genderStepText", comment: "")
        let genderStep = ORKQuestionStep(identifier: genderStepID, title: genderStepText, answer: ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices))
        return genderStep

    }
    infosteps.append(genderStep())


    let ageStep = { () -> ORKQuestionStep in
        let ageStepText = NSLocalizedString("InfoTask.ageStepText", comment: "")
        let ageStep = ORKQuestionStep(identifier: ageStepID, title: ageStepText, answer: ORKAnswerFormat.integerAnswerFormat(withUnit: NSLocalizedString("InfoTask.unit", comment: "")))
        return ageStep
    }
    infosteps.append(ageStep())

    return ORKOrderedTask(identifier: "InfoTask", steps: infosteps)


}
