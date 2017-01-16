//
//  Analyse.swift
//  OtsimoTest
//
//  Created by demirci on 16/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit


class Analyse {
    
    var Results = Mchat_Result()
    
    
    func AnalyseTask(taskResult: ORKTaskResult){
        Log.debug("Analyse : AnalyseTask")
        
        var taskResults: [Mchat_QuestionResult] = []
        if let tskResult = taskResult.results {
            print("1")
            for results in tskResult {
                print("2")

                let sresults = results as! ORKStepResult
                if let stepResult = sresults.results {
                    print("3")

                    for r in stepResult {
                        print("4")

                        var qResult = Mchat_QuestionResult()
                        let br = r as! ORKBooleanQuestionResult
                        qResult.id = br.identifier
                        if let a = br.booleanAnswer {
                            print("5")

                            if a == 1 {
                                qResult.answer = true
                            } else if a == 0 {
                                qResult.answer = false
                            }
                            taskResults.append(qResult)
                        }
                    }
                }
            }
        }
        self.Results.stepResults = taskResults
        print("ENDRESULT----->", self.Results)
    }
    func AnalyseInfoResult(infoResult: ORKTaskResult){
        Log.debug("Analyse : AnalyseInfoResult")
        if let iResults = infoResult.results {
            print("1")
            for results in iResults {
                print("2")
                let sresults = results as! ORKStepResult
                if let stepResult = sresults.results {
                    print("3")
                    if sresults.identifier == "relation" {
                        print("4")
                        let r = stepResult[0] as! ORKChoiceQuestionResult
                        print("--- ",r)
                        print(r.)
                        //self.Results.relation = r.answer as! String
                    }
                    print("5")
                    if sresults.identifier == "age" {
                        let r = stepResult[0] as! ORKNumericQuestionResult
                        print("--- ",r)
                        self.Results.age = r.answer as! String
                    }
                    
                }
            }
        }

    }

    
}
