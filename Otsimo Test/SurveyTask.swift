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

    public var manager: Pollster
    init(_ pollster: Pollster) {
        self.manager = pollster
    }

    public var identifier: String { get { return "survey" } }
    public func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {

        Log.debug("step : before : result -> \(result)")
//        if (result.results?.isEmpty)! {
//            return nil
//        }

        if manager.currentQuestionID == "sum" || manager.currentQuestionID == "0:0"{
            manager.currentQuestionID = "0:0"

            return nil
        }
        if let sl = result.results, sl.count > 0 {
            if let stepResult = sl.last as? ORKStepResult {
                print("***************** *****************  stepResult -> \(stepResult)")
                if let srr = stepResult.results, srr.count > 0 {
                    //if result have one answer, then it is yes no question
                    if srr.count == 1 {
                        if let bqr = srr[0] as? ORKBooleanQuestionResult {
                            if let a = bqr.booleanAnswer {
                                if a == 1 {
                                    manager.handleAnswerForYesNo(answer: true)
                                } else if a == 0 {
                                    manager.handleAnswerForYesNo(answer: false)
                                }
                            }
                        }
                    } else {
                        //Else it is a group question
                        manager.handleAnswerForGroupQuestion(Results: stepResult)
                    }
                }
            }
        }
        return nil
    }

    var total = 0
    public func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        Log.debug("step::after current=\(manager.currentQuestionID) last=\(manager.lastQuestionID)")
        if manager.currentQuestionID == manager.lastQuestionID {
            return nil
        }
        if manager.currentQuestionID == "sum" {
            let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
            summaryStep.title = "Thank you."
            summaryStep.text = "We appreciate your time."
            return summaryStep
        }
        Log.debug("let q = manager.getQuestion(id: manager.currentQuestionID)")
        let q = manager.getQuestion(id: manager.currentQuestionID)
        if manager.isYesNoQuestion(id: manager.currentQuestionID) {
            Log.debug("current quesiton = \(manager.currentQuestionID) is yes no question")
            let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: ORKAnswerFormat.booleanAnswerFormat())
            step.isOptional = false
            return step
        } else if manager.isGroup(id: manager.currentQuestionID){
            Log.debug("current quesiton = \(manager.currentQuestionID) is group question")
            //Create Group question
            let step = ORKFormStep(identifier: manager.currentQuestionID, title: q.text, text: q.text)
            step.formItems = []
            step.isOptional = false
            for gq in (q.group?.questions)! {
                
                let s = parseID(id: manager.currentQuestionID).0
                
                let gqID = s + ":" + String(gq.key)
                let gquestion = manager.getQuestion(id: gqID)
                let stepItem = ORKFormItem(identifier: gqID, text: gquestion.text, answerFormat: ORKAnswerFormat.booleanAnswerFormat())
                stepItem.isOptional = false

                step.formItems? = (step.formItems)! + [stepItem]
            }
            return step
        }
        return nil
    }

    public func step(withIdentifier identifier: String) -> ORKStep? {
        Log.debug("step : withIdentifier")
        let q = manager.getQuestion(id: manager.currentQuestionID)
        let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: ORKAnswerFormat.booleanAnswerFormat())
        step.isOptional = false
        return nil
    }
    
    

    ////


}
