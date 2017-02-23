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
    
    for i in 1...20{
        let id = "q" + String(i)
        let key = id + ".1"
        let title = NSLocalizedString(key, comment: "")
        let step = ORKQuestionStep(identifier: id, title: title, answer: ORKAnswerFormat.booleanAnswerFormat())
        mChatsteps.append(step)
    }
    
    
    
    return ORKOrderedTask(identifier: Tasks.mChatTaskID, steps: mChatsteps)
}
