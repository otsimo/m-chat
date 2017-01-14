//
//  Pollster.swift
//  OtsimoTest
//
//  Created by demirci on 06/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit


public class Pollster {
    var currentQuestionID: String
    var currentStepID: String
    var lastQuestionID: String = "0"
    var steps: [Otsimo_Mchat_Step]

    var passNum = 0
    var failNum = 0

    init(steps: [Otsimo_Mchat_Step], firstStep: String) {
        self.steps = steps
        self.currentQuestionID = generateID(stepID: firstStep, questionID: (steps.first!.id))
        let ids = parseID(id: self.currentQuestionID)
        self.currentStepID = ids.0
    }


    func handleAnswerForYesNo(answer: Bool) {

        let (sNum, qNum) = getStepAndQuestion(id: currentQuestionID)

        if let yn = qNum.yesno {

            if answer {
                switch yn.yes.result {
                case .askAnother:
                    currentQuestionID = generateID(stepID: sNum.id, questionID: yn.yes.nextQuestion)
                    break
                case .pass:
                    break
                case .fail:
                    break
                default:
                    break
                }
            } else {
                switch yn.no.result {
                case .askAnother:
                    currentQuestionID = generateID(stepID: sNum.id, questionID: yn.yes.nextQuestion)
                    break
                case .pass:
                    break
                case .fail:
                    break
                default:
                    break
                }
            }
        }
    }

    func handleAnswerForGroupQuestion(Results: ORKStepResult) {
        Log.debug("handleAnswerForGroupQuestion \(Results)")

        let resultID = Results.identifier
        let parentIDs = parseID(id: resultID)
        let parentStepNum = parentIDs.0
        let parentNum = parentIDs.1
        var querys: [Otsimo_Mchat_Query] = []



        let (cstep, cc) = getStepAndQuestion(id: currentQuestionID)
        print("Parent Question \(currentQuestionID)")


        //Then Group Result
        var groupAnswers: [GroupAnswer] = []

        if let results = Results.results {
            for result in results {
                let bqr = result as! ORKBooleanQuestionResult
                let qID = bqr.identifier
                let qIDs = parseID(id: qID)
                let qNum = qIDs.1
                let answer = bqr.booleanAnswer == 1

                if let groupName = cc.group!.questions[qNum] {
                    var a = GroupAnswer(id: qNum, answer: answer, groupName: groupName)
                    groupAnswers.append(a)

                } else {
                    var a = GroupAnswer(id: qNum, answer: answer, groupName: "")
                    groupAnswers.append(a)

                }


            }
        }


        if let qs = cc.group?.query {
            for q in qs {
                if let queryResult = runQuery(query: q, answers: groupAnswers) {

                    switch queryResult {
                    case .askAnother:
                        currentQuestionID = generateID(stepID: cstep.id, questionID: q.nextQuestion)
                        break
                    case .pass:
                        passNum += 1
                        Log.debug("pass")
                        break
                    case .fail:
                        failNum += 1
                        Log.debug("fail")
                        break
                    default:
                        break
                    }
                }
            }

            let cindex = steps.index(of: cstep)!
            if cindex + 1 >= steps.count {
                //Completed
            }
            let nextStep = steps[cindex + 1]
                currentQuestionID = generateID(stepID: nextStep.id, questionID: nextStep.firstQuestion)
        }
    }



    func runQuery(query: Otsimo_Mchat_Query, answers: [GroupAnswer]) -> Otsimo_Mchat_ResultType? {

        let answerofGroup = answers.filter { (ga) -> Bool in

            return query.group == "" || ga.groupName == query.group
        }
        for action in query.actions {
            switch action {
            case .allOfYes:
                if AllOfYes(groupAnswers: answerofGroup) {
                    return query.result
                }
            case .allOfNo:
                if AllOfNo(groupAnswers: answerofGroup) {
                    return query.result
                }

            case .mostOftenNo:
                if MostOftenYesNo(groupAnswers: answerofGroup, checkYes: false) {
                    return query.result
                }
            case .mostOftenYes:
                if MostOftenYesNo(groupAnswers: answerofGroup, checkYes: true) {
                    return query.result
                }
            case .oneOfNo:
                if oneOfNo(groupAnswers: answerofGroup) {
                    return query.result
                }
            case .oneOfYes:
                if oneOfYes(groupAnswers: answerofGroup) {
                    return query.result
                }
            default:
                break
            }
        }
        return nil
    }

    func isGroup(id: String) -> Bool {

        let (sNum, qNum) = getStepAndQuestion(id: id)
        if let grp = qNum.group {
            return true
        }
        return false
    }
    func isYesNoQuestion(id: String) -> Bool {

        let (sNum, qNum) = getStepAndQuestion(id: id)
        if let grp = qNum.yesno {
            return true
        }
        return false
    }

}
