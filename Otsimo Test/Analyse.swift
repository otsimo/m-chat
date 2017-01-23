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

    func Task(result: ORKTaskResult, iresult: Otsimo_Info) -> Otsimo_Result {
        Log.debug("Analyse : AnalyseTask")
        var AnalysedResults = Otsimo_Result()
        AnalysedResults.device = Otsimo_DeviceInfo(os: "ios")
        AnalysedResults.version = OtsimoResultVersion
        print("iresult = ", iresult)

        AnalysedResults.info = iresult

        var stepResults: [Otsimo_StepResult] = []
        if let tskResult = result.results {
            for results in tskResult {
                print("id->", results.identifier, "start ->", results.startDate, "\nEnd ->", results.endDate, "\n")
                var sResult = Otsimo_StepResult()
                var qResults: [Otsimo_QuestionResult] = []

                let sresults = results as! ORKStepResult
                if let stepResult = sresults.results {
                    for r in stepResult {
                        var qResult = Otsimo_QuestionResult()
                        let br = r as! ORKBooleanQuestionResult
                        qResult.id = br.identifier
                        if let a = br.booleanAnswer {
                            print(a == 1)
                            if a == 1 {
                                qResult.answer = "YES"
                            } else {
                                qResult.answer = "NO"
                            }
                            qResults.append(qResult)
                        }
                    }
                }
                sResult.stepResult = qResults
                stepResults.append(sResult)
            }
        }
        AnalysedResults.stepResults = stepResults

        print("AnalysedResults ->", AnalysedResults)
        return AnalysedResults
    }

    func InfoResult(infoResult: ORKTaskResult) -> Otsimo_Info {

        Log.debug("Analyse : AnalyseInfoResult")
        var iresult = Otsimo_Info()

        if let iResults = infoResult.results {
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
                    if sresults.identifier == ageStepID {
                        let r = stepResult[0] as! ORKNumericQuestionResult
                        if let answer = r.numericAnswer {
                            iresult.age = String(answer.int64Value)
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
