//
//  Analyse.swift
//  OtsimoTest
//
//  Created by demirci on 16/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftProtobuf


let OtsimoResultVersion : Int32 = 1

class InfoResult{
    var age = String()
    var relation = String()
}

class Analyse {

    var iresult = InfoResult()
    
    var beforeID = "0:0"

    func analyseTask(result: ORKTaskResult)->Otsimo_Result {
        Log.debug("Analyse : AnalyseTask")
        var AnalysedResults = Otsimo_Result()
        AnalysedResults.device = Otsimo_DeviceInfo(os:"ios")
        AnalysedResults.version = OtsimoResultVersion
        print("Age = ",iresult.age,"Relation = ",iresult.relation)
        AnalysedResults.age = iresult.age
        AnalysedResults.relation = iresult.relation
        
        var taskResults: [Otsimo_StepResult] = []
        if let tskResult = result.results {
            for results in tskResult {

                var sResult = Otsimo_StepResult()
                var qResults: [Otsimo_QuestionResult] = []

                let sresults = results as! ORKStepResult
                if let stepResult = sresults.results {


                    for r in stepResult {

                        var qResult = Otsimo_QuestionResult()
                        let br = r as! ORKBooleanQuestionResult
                        qResult.id = br.identifier
                        if let a = br.booleanAnswer {
                            if a == 1 {
                                qResult.answer = true
                            } else if a == 0 {
                                qResult.answer = false
                            }
                            qResults.append(qResult)
                        }


                    }

                }

                sResult.stepResult = qResults

                if results.identifier != "SummaryStep" {
                    let id = parseID(id: results.identifier).0
                    let bid = parseID(id: beforeID).0

                    if id == bid {
                        print("2", "results.identifier=", results.identifier, " beforeID=", beforeID)
                        sResult.id = id
                        sResult.stepResult = qResults + taskResults.last!.stepResult
                    }
                }
                taskResults.append(sResult)
                beforeID = results.identifier
            }
        }
        AnalysedResults.stepResults = taskResults
        
        return AnalysedResults
    }
    
    func analyseInfoResult(infoResult: ORKTaskResult) {
        Log.debug("Analyse : AnalyseInfoResult")
        if let iResults = infoResult.results {
            for results in iResults {
                let sresults = results as! ORKStepResult
                if let stepResult = sresults.results {
                    if sresults.identifier == "relation" {
                        let r = stepResult[0] as! ORKChoiceQuestionResult
                        if let answers = r.choiceAnswers {
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
                            iresult.relation = a
                        }
                    }
                    if sresults.identifier == "age" {
                        let r = stepResult[0] as! ORKNumericQuestionResult
                        if let answer = r.numericAnswer {
                            print(answer)
                            iresult.age = String(answer.int64Value)
                        }


                    }

                }
            }
        }
    }


}
