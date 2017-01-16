//
//  QuestionFunctions.swift
//  OtsimoTest
//
//  Created by demirci on 14/01/2017.
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


extension Pollster{
    
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
    

}
