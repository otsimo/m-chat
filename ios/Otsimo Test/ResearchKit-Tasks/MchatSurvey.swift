//
//  mchatSurvey.swift
//  OtsimoTest
//
//  Created by demirci on 14/02/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit

public var MChatTask: ORKOrderedTask {
    
    
    var mChatsteps = [ORKStep]()
    
    for i in 1...23{
        let id = "q" + String(i)
        let key = id + ".1"
        let title = NSLocalizedString(key, comment: "")
        let step = CustomStep(identifier: id)
        step.text = title
        step.answerFormat = ORKAnswerFormat.booleanAnswerFormat()
        mChatsteps.append(step)
    }
    
    let summaryStep = ORKCompletionStep(identifier: "sum-mChat")
    summaryStep.title = NSLocalizedString("summaryStep.title", comment: "")
    summaryStep.text = NSLocalizedString("We appreciate your time.", comment: "")
    // mChatsteps.append(summaryStep)
    
    return ORKOrderedTask(identifier: Tasks.mChatTaskID, steps: mChatsteps)
}
