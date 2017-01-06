//
//  Pollster.swift
//  OtsimoTest
//
//  Created by demirci on 06/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

func generateID(stepID: String, questionID: String) -> String {
    return stepID + ":" + questionID
}
func parseID(id: String) -> (String, String) {
    var idArray = id.components(separatedBy: ":")
    return (idArray[0], idArray[1])
}


public class Pollster{
    var currentQuestionID: String
    var lastQuestionID: String = "0"
    var steps: [Otsimo_Mchat_Step]
    
    init(steps: [Otsimo_Mchat_Step], firstStep: String) {
        self.steps = steps
        currentQuestionID = generateID(stepID: firstStep, questionID: (steps.first!.id))
    }
    
    func getQuestion(id: String) -> Otsimo_Mchat_Question {
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNUm = ids.1
        
        for s in steps {
            if s.id == stepNum {
                for q in s.questions {
                    if q.id == qNUm {
                        return q
                    }
                }
            }
        }
        return Otsimo_Mchat_Question()
    }
    
    func getStepAndQuestion(id: String) -> (Otsimo_Mchat_Step, Otsimo_Mchat_Question) {
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNUm = ids.1
        
        for s in steps {
            if s.id == stepNum {
                for q in s.questions {
                    if q.id == qNUm {
                        return (s, q)
                    }
                }
            }
        }
        return (Otsimo_Mchat_Step(), Otsimo_Mchat_Question())
    }
    
    func handleAnswer(answer:Bool){
        
    }
}
