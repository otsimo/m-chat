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
    
    
    func AnalyseTask(result: ORKTaskResult){
        Log.debug("Analyse : AnalyseTask")
        
        var taskResults: [Mchat_QuestionResult] = []
        if let tskResult = result.results {
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
        self.Results.stepResults += taskResults
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
                        
                        if let answers = r.choiceAnswers{
                            print(answers[0])
                            var a = ""
                            switch answers[0] as! Int {
                            case 1:
                                a = "Parent"
                            case 2:
                                a = "GrandParent"
                            case 3:
                                a = "Guardion"
                            case 4:
                                a = "Educator"
                            case 5:
                                a = "Healt care provider"
                            case 6:
                                a = "other"
                            default:
                                break
                            }
                            self.Results.relation = a
                        }
                    }
                    print("5")
                    if sresults.identifier == "age" {
                        let r = stepResult[0] as! ORKNumericQuestionResult
                        print("--- ",r)
                        
                        if let answer = r.numericAnswer{
                            print(answer)
                            self.Results.age = String(answer.int64Value)
                        }
                        
                        
                    }
                    
                }
            }
        }
        print("1 ENDRESULT----->", self.Results)
    }

    
}
