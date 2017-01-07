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
    print("parseID ->",id)
    var idArray = id.components(separatedBy: ":")
    return (idArray[0], idArray[1])
}


public class Pollster{
    var currentQuestionID: String
    var currentStepID: String
    var lastQuestionID: String = "0"
    var steps: [Otsimo_Mchat_Step]
    
    init(steps: [Otsimo_Mchat_Step], firstStep: String) {
        self.steps = steps
        currentQuestionID = generateID(stepID: firstStep, questionID: (steps.first!.id))
        let ids = parseID(id: currentQuestionID)
        currentStepID = ids.0
    }
    
    func getQuestion(id: String) -> Otsimo_Mchat_Question {
        //Log.debug("getQuestion id = \(id)")
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
       //Log.debug("getStepAndQuestion id = \(id)")
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNum = ids.1
        
        for s in steps {
            if s.id == stepNum {
                for q in s.questions {
                    if q.id == qNum {
                        return (s, q)
                    }
                }
            }
        }
        return (Otsimo_Mchat_Step(), Otsimo_Mchat_Question())
    }
    
    func handleAnswer(answer:Bool){
        let ids = parseID(id: currentQuestionID)
        let stepNum = ids.0
        let qNum = ids.1
        
        for s in steps{
            if s.id == stepNum{
                for q in s.questions{
                    if q.id == qNum{
                        if let yn = q.yesno{
                            
                            if answer{
                                if yn.yes.result == Otsimo_Mchat_ResultType.askAnother{
                                    currentQuestionID = generateID(stepID: stepNum, questionID: yn.yes.nextQuestion)
                                }
                            }else{
                                if yn.no.result == Otsimo_Mchat_ResultType.askAnother{
                                    currentQuestionID = generateID(stepID: stepNum, questionID: yn.no.nextQuestion)
                                }
                            }
                            
                            
                        }else if let group = q.group{
                            Log.debug("This is group")
                        }
                    }
                }
            }
        }
        
        if answer{
            
            
        }
    }
    func isGroup(id : String) -> Bool{
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNum = ids.1
        
        for s in steps{
            if s.id == stepNum{
                for q in s.questions{
                    if q.id == qNum{
                        if let grp = q.group{
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    func isYesNoQuestion(id : String) -> Bool{
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNum = ids.1
        
        for s in steps{
            if s.id == stepNum{
                for q in s.questions{
                    if q.id == qNum{
                        if let yn = q.yesno{
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    
}
