//
//  Analyse-mChat.swift
//  OtsimoTest
//
//  Created by demirci on 17/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import ResearchKit

extension Analyse {
    enum InfoStepIDs {
        static let relationStepID = "relation"
        static let genderStepID = "gender"
        static let birthDayStepID = "birthDay"
    }

    func getMchatAnalysedResult(results: [ORKResult]) -> Otsimo_Result {
        var analysedResults = Otsimo_Result()
        analysedResults.device = Otsimo_DeviceInfo(os: "ios")
        analysedResults.version = OtsimoResultVersion
        analysedResults.surveyType = Otsimo_SurveyType.mchatrf

        var info = Otsimo_Info()
        let stepResult = results as! [ORKStepResult]
        for result in stepResult {
            switch result.identifier {
            case InfoStepIDs.relationStepID:
                if let r = result.results {
                   // info.relation = getTextChociesAnswerForRelation(index: choiceResult.answer as! Int)
                    let cResult = r[0] as! ORKChoiceQuestionResult

                    if let answers = cResult.choiceAnswers {
                        
                        let choice = getTextChociesAnswerForRelation(index: answers[0] as! Int)
                        info.relation = NSLocalizedString(String(describing: choice), comment: "")
                    }

                }
            case InfoStepIDs.birthDayStepID:
                if let r = result.results {
                    let choiceResult = r[0] as! ORKChoiceQuestionResult
                }
            case InfoStepIDs.genderStepID:
                if let r = result.results {
                    let cResult = r[0] as! ORKChoiceQuestionResult
                    if let answers = cResult.choiceAnswers {
                        let choice = getTextChociesAnswerForGender(index: answers[0] as! Int)
                        info.gender = NSLocalizedString(String(describing: choice), comment: "")
                    }

                }
            default:
                break
            }

        }



        return analysedResults
    }

}
