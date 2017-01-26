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


let OtsimoResultVersion: Int32 = 1

class Analyse {
    
    func getAnalyzedResult(iresult: Otsimo_Info , sresults : [Otsimo_StepResult]) -> Otsimo_Result{
        var analysedResults = Otsimo_Result()
        analysedResults.device = Otsimo_DeviceInfo(os: "ios")
        analysedResults.version = OtsimoResultVersion
        analysedResults.info = iresult
        analysedResults.stepResults = sresults
    
        return analysedResults
    }
    
    

    func Task(result: ORKTaskResult) -> [Otsimo_StepResult] {
        Log.debug("Analyse : AnalyseTask")
        var AnalysedResults = Otsimo_Result()
        
        
        var stepResults: [Otsimo_StepResult] = []
        var subStepResults: [Otsimo_SubStepResult] = []
        if let tskResult = result.results{
            
            
            
            for results in tskResult{
                print("id->", results.identifier, "start ->", results.startDate, "\nEnd ->", results.endDate, "\n")
                var subStepResult = Otsimo_SubStepResult()
                var qResults : [Otsimo_QuestionResult] = []
                let sresults = results as! ORKStepResult
                
                
                if results.identifier == "SummaryStep"{
                    var stepResult = Otsimo_StepResult()
                    stepResult.subStepResults += subStepResults
                    stepResult.id = parseID(id: (subStepResults.last?.id)!).0
                    stepResults.append(stepResult)
                }
                
                
                if let stepresult = sresults.results{
                    for r in stepresult{
                        var qResult = Otsimo_QuestionResult()
                        let br = r as! ORKBooleanQuestionResult
                        qResult.id = br.identifier
                        
                        if let a = br.booleanAnswer{
                            if a == 1{
                                qResult.answer = "YES"
                            }else{
                                qResult.answer = "NO"
                            }
                        }
                        qResults.append(qResult)
                        
                    }
                    subStepResult.stepResults = qResults
                    subStepResult.id = sresults.identifier
                    subStepResult.startDate = Int64(sresults.startDate.timeIntervalSince1970)
                    subStepResult.endDate = Int64(sresults.endDate.timeIntervalSince1970)
                }
                
                if subStepResults == []{
                    subStepResults.append(subStepResult)
                }else if subStepResult.id != "SummaryStep"{
                    let id = parseID(id: (subStepResults.last?.id)!).0
                    let subStepResultID = parseID(id: subStepResult.id).0
                    
                    if id == subStepResultID {
                        subStepResults.append(subStepResult)
                    }else{
                        var stepResult = Otsimo_StepResult()
                        stepResult.subStepResults += subStepResults
                        stepResult.id = id
                        stepResults.append(stepResult)
                        subStepResults = [subStepResult]
                    }
                   
                }
                
                
                
                subStepResults.append(subStepResult)
            }
            
            
        }
        
        print("stepResults ----->> \n",stepResults)
        
        return stepResults
    }

    func InfoResult(infoResult: ORKTaskResult) -> Otsimo_Info {

        Log.debug("Analyse : AnalyseInfoResult")
        var iresult = Otsimo_Info()

        if let iResults = infoResult.results {
            print(iResults)
            
            for results in iResults {
                let sresults = results as! ORKStepResult
                if let stepResult = sresults.results {
                    if sresults.identifier == relationStepID {
                        let r = stepResult[0] as! ORKChoiceQuestionResult
                        if let answers = r.choiceAnswers {

                            let choice = getTextChociesAnswerForRelation(index: answers[0] as! Int)
                            iresult.relation = NSLocalizedString(String(describing: choice), comment: "")
                        }
                    }
                    if sresults.identifier == genderStepID {
                        let r = stepResult[0] as! ORKChoiceQuestionResult
                        if let answers = r.choiceAnswers {
                            let choice = getTextChociesAnswerForGender(index: answers[0] as! Int)
                            iresult.gender = NSLocalizedString(String(describing: choice), comment: "")
                        }
                    }
                    if sresults.identifier == birthDayStepID {
                        print(stepResult[0])
                        let r = stepResult[0] as! ORKDateQuestionResult
                        
                        if let dateAnswer = r.dateAnswer{
                            iresult.birthDay = Int64(dateAnswer.timeIntervalSince1970)
                        }
                    }
                }
            }
        }
        print("******************iresult->", iresult)

        return iresult
    }




    func getTextChociesAnswerForRelation(index: Int) -> Relation {

        switch index {
        case 1:
            return .parent
        case 2:
            return .grandParent
        case 3:
            return .guardion
        case 4:
            return .educator
        case 5:
            return .healtCareProvider
        case 6:
            return .other
        default:
            return Relation.other
        }
    }

    func getTextChociesAnswerForGender(index: Int) -> Gender {
        switch index {
        case 1:
            return .male
        case 2:
            return .female
        default:
            return .other
        }
    }

}
