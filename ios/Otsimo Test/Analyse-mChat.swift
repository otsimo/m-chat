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
        analysedResults.surveyType = Otsimo_SurveyType.mchat

        var info = Otsimo_Info()
        var stepResults = [Otsimo_StepResult]()
        let stepResult = results as! [ORKStepResult]
        for result in stepResult {
            switch result.identifier {
            case InfoStepIDs.relationStepID:
                print("InfoStepIDs.relationStepID")
                if let r = result.results {
                   // info.relation = getTextChociesAnswerForRelation(index: choiceResult.answer as! Int)
                    let cResult = r[0] as! ORKChoiceQuestionResult

                    if let answers = cResult.choiceAnswers {
                        
                        let choice = getTextChociesAnswerForRelation(index: answers[0] as! Int)
                        info.relation = NSLocalizedString(String(describing: choice), comment: "")
                    }

                }
            case InfoStepIDs.birthDayStepID:
                 print("InfoStepIDs.birthDayStepID")
                if let r = result.results {
                    let dateResult = r[0] as! ORKDateQuestionResult
                    print("date Result->",dateResult)
                }
            case InfoStepIDs.genderStepID:
                 print("InfoStepIDs.genderStepID")
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
            if (result.identifier.characters.first == "q"){
                print("default question : result",result)
                
                if let r = result.results{
                    let cResult = r[0] as! ORKBooleanQuestionResult
                    if let answer = cResult.booleanAnswer{
                        var stepResult = Otsimo_StepResult()
                        var subStepResults = [Otsimo_SubStepResult]()
                        var subStepResult = Otsimo_SubStepResult()
                        subStepResult.id = cResult.identifier
                        subStepResult.startDate = Int64(cResult.startDate.timeIntervalSince1970)
                        subStepResult.endDate = Int64(cResult.endDate.timeIntervalSince1970)
                        var questionResults = [Otsimo_QuestionResult]()
                        var questionResult = Otsimo_QuestionResult()
                        questionResult.id = cResult.identifier
                        questionResult.answer = String(describing: answer)
                        questionResults.append(questionResult)
                        subStepResult.stepResults.append(questionResult)
                        subStepResults.append(subStepResult)
                        stepResult.subStepResults = subStepResults
                        stepResults.append(stepResult)
                    }
                }

            }

        }


        analysedResults.info = info
        analysedResults.stepResults = stepResults
        analysedResults.userId = NSUUID().uuidString
        let userDefaults = UserDefaults.standard
        userDefaults.set(analysedResults.userId, forKey: CacheKeys.userIDKey)
        return analysedResults
    }

}
