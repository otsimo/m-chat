//
//  SurveyTask2.swift
//  Otsimo Test
//
//  Created by demirci on 30/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit



public class SurveyTask: NSObject, ORKTask {
    
    //we used in SurveyTask extension
    let YesAnswer = "Yes"
    let NoAnswer = "No"
    //

    let introStepID = "introStep"
    let q1StepID = "q1"

    let summaryStepID = "summaryStep"
    public var identifier: String { get { return "survey" } }

    public func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        switch step?.identifier {
        case .some(q1StepID):
            return self.step(withIdentifier: introStepID)

        case .some(summaryStepID):
            return self.step(withIdentifier: q1StepID)

        default:
            return nil
        }
    }



    public func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        switch step?.identifier {
        case .none:
            return self.step(withIdentifier: introStepID)
        case .some(introStepID):
            return self.step(withIdentifier: q1StepID)
        case .some(q1StepID):
            return self.step(withIdentifier: summaryStepID)
        default:
            return nil
        }
    }






    public func step(withIdentifier identifier: String) -> ORKStep? {




        switch identifier {

        case introStepID:
            let introStep = ORKInstructionStep(identifier: introStepID)
            introStep.title = NSLocalizedString("intro.title", comment: "1")
            introStep.text = NSLocalizedString("intro.text", comment: "2")
            return introStep

        case q1StepID:
            let q1Step = ORKQuestionStep(identifier: q1StepID)
            q1Step.title = NSLocalizedString("q1.main", comment: "3")
            q1Step.answerFormat = ORKBooleanAnswerFormat()
            return q1Step

        case summaryStepID:
            let summaryStep = ORKCompletionStep(identifier: summaryStepID)
            summaryStep.title = NSLocalizedString("summary.title", comment: "4")
            summaryStep.text = NSLocalizedString("summary.title", comment: "5")
            return summaryStep

        default:
            return nil
        }
    }


    ////


}
