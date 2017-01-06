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


    public func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        
        isStarted = true
        Log.debug("step : before")
//        if (result.results?.isEmpty)! {
//            return nil
//        }
        if let sl = result.results, sl.count > 0 {
            print("1")
            if let stepResult = sl[0] as? ORKStepResult {
                print("2")

                if let srr = stepResult.results, srr.count > 0 {
                    print("3")

                    if let bqr = srr[0] as? ORKBooleanQuestionResult {
                        print("4")
                        if let a = bqr.booleanAnswer{
                            if a == 1{
                                manager.handleAnswer(answer: true)
                            }else if a == 0{
                                manager.handleAnswer(answer: false)
                            }
                        }
                        
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
        let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: ORKAnswerFormat.booleanAnswerFormat())
        step.isOptional = false
        return step

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
