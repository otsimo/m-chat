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
        print("step(before ")
        if (result.results?.isEmpty)! {
            return nil
        }
        if let sl = result.results, sl.count > 1 {
            if let stepResult = sl[0] as? ORKStepResult {
                if let srr = stepResult.results, srr.count > 0 {
                    if let bqr = srr[0] as? ORKBooleanQuestionResult {
                        print(bqr.booleanAnswer)
                    }
                }
            }
        }
        let (s, q) = manager.getStepAndQuestion(id: manager.currentQuestionID)

        return nil
    }
    /*
     Shows current question
 */


    public func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
      /*  print("step::after", isStarted,"x=",x,"current",currentQuestionID,"last",lastQuestionID)
        x += 1
        
        guard !(currentQuestionID == lastQuestionID || x < 2) else {
            print("guard", isStarted,currentQuestionID,lastQuestionID)
            return nil
        }
        */
        let q = manager.getQuestion(id: manager.currentQuestionID)
        let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: ORKAnswerFormat.booleanAnswerFormat())
        step.isOptional = false
        return step

    }

    public func step(withIdentifier identifier: String) -> ORKStep? {
        let q = manager.getQuestion(id: manager.currentQuestionID)
        let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: ORKAnswerFormat.booleanAnswerFormat())
        step.isOptional = false
        return step
    }


    ////


}
