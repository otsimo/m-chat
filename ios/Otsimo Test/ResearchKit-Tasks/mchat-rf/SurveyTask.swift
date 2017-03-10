//
//  SurveyTask2.swift
//  Otsimo Test
//
//  Created by demirci on 30/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit


let summaryStepID = "SummaryStepID"
public class SurveyTask: NSObject, ORKTask {

    public var manager: Pollster
    init(_ pollster: Pollster) {
        self.manager = pollster
    }

    public var identifier: String { get { return Tasks.mChatRFTaskID } }
    public func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        Log.debug("step::before current=\(manager.currentQuestionID) last=\(manager.lastQuestionID)")

        if manager.currentQuestionID == manager.lastQuestionID {
            return nil
        }
        if manager.currentQuestionID == summaryStepID {
            manager.currentQuestionID = manager.lastQuestionID
        }
        return nil
    }

    var total = 0
    public func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        Log.debug("step::after current=\(manager.currentQuestionID) last=\(manager.lastQuestionID)")

        if manager.currentQuestionID == manager.lastQuestionID {
            print("manager.currentQuestionID == manager.lastQuestionID")
            return nil
        }
        
        handle(with: result)

        if manager.currentQuestionID == "sum" {
            manager.currentQuestionID = manager.lastQuestionID
            return getSummaryStep()
        }
        if manager.isYesNoQuestion(id: manager.currentQuestionID) {
            return getYesNoStep(with: manager.currentQuestionID)
        } else if manager.isGroup(id: manager.currentQuestionID) {
            return getGroupStep(with: manager.currentQuestionID)
        }
        return nil
    }

    
    public func step(withIdentifier identifier: String) -> ORKStep? {
        Log.debug("step : withIdentifier")
        let q = manager.getQuestion(id: manager.currentQuestionID)
        let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: .booleanAnswerFormat())
        step.isOptional = false
        return nil
    }


    public func progress(ofCurrentStep step: ORKStep, with result: ORKTaskResult) -> ORKTaskProgress {

        var progress = ORKTaskProgress()
        print(manager.currentQuestionID)
        if manager.currentQuestionID != "sum" && manager.currentQuestionID != manager.lastQuestionID {
            let stepNum = parseID(id: manager.currentQuestionID).0
            if let num = UInt(stepNum) {
                progress = ORKTaskProgressMake(num - 1, 20)
            }
        } 
        return progress
    }


    func handle(with result: ORKTaskResult) {
        print("Current", manager.currentQuestionID)
        //print("RESULT ->>>>>>>", result)
        if let sl = result.results, sl.count > 0 {
            if let stepResult = sl.last as? ORKStepResult {
                if stepResult.identifier == manager.currentQuestionID {
                    if let srr = stepResult.results, srr.count > 0 {
                        //if result have one answer, then it is yes no question
                        if srr.count == 1 {
                            if let bqr = srr[0] as? ORKBooleanQuestionResult {
                                if let a = bqr.booleanAnswer {
                                    manager.handleAnswerForYesNo(answer: (a == 1))
                                }
                            }
                        } else {
                            //Else it is a group question
                            //print("Current Question id", manager.currentQuestionID, "and handleAnswerForGroupQuestion", " **********\n*********and Step Result",stepResult)
                            print("handle : else")
                            manager.handleAnswerForGroupQuestion(Results: stepResult)
                            print("current in else->",manager.currentQuestionID)
                        }
                    }
                }
            }
        }

    }
}
