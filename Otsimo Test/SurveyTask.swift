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

    var isStarted: Bool = false
    var x = 0

    var manager: Pollster

    init(_ pollster: Pollster) {
        self.manager = pollster
    }

    public var identifier: String { get { return "survey" } }

    var f = 0
    public func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {

        isStarted = true
        Log.debug("step : before : result -> \(result)")
//        if (result.results?.isEmpty)! {
//            return nil
//        }

        if let sl = result.results, sl.count > 0 {
            print("1")
            print("***************** StepResult count -> \(sl.count)")
            if let stepResult = sl.last as? ORKStepResult {
                print("***************** *****************  stepResult -> \(stepResult)")
                if let srr = stepResult.results, srr.count > 0 {
                    print("3")
                    print("srr ->", srr, " x=", x)
                    print("Ara")

                    //if result have one answer, then it is yes no question
                    if srr.count == 1 {
                        if let bqr = srr[0] as? ORKBooleanQuestionResult {
                            print("bqr ->", bqr)
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


    public func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        Log.debug("step::after \(isStarted) x=\(x) current=\(manager.currentQuestionID) last=\(manager.lastQuestionID)")
        if manager.currentQuestionID == manager.lastQuestionID {
            return nil
        }

        let q = manager.getQuestion(id: manager.currentQuestionID)


        if manager.isYesNoQuestion(id: manager.currentQuestionID) {
            Log.debug("current quesiton is yes no question")
            let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: ORKAnswerFormat.booleanAnswerFormat())
            step.isOptional = false
            return step
        } else {
            Log.debug("current quesiton is group question")
            //Create Group question
            var step = ORKFormStep(identifier: manager.currentQuestionID, title: q.text, text: q.text)
            step.formItems = []
            step.isOptional = false
            for gq in (q.group?.questions)! {
                print("***->", gq.key)
                let gqID = manager.currentStepID + ":" + String(gq.key)
                let gquestion = manager.getQuestion(id: gqID)
                print("**->", gquestion.text, "gqID->", gqID)
                let stepItem = ORKFormItem(identifier: gqID, text: gquestion.text, answerFormat: ORKAnswerFormat.booleanAnswerFormat())
                stepItem.isOptional = false
                step.formItems? = (step.formItems)! + [stepItem]
            }
            print(step.formItems)
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
