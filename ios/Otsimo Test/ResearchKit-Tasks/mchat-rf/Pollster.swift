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
    var lastQuestionID: String = "afterSum"
    var steps: [Otsimo_Mchat_Step]
    var stepNum = 1

    var passNum = 0
    var failNum = 0
    

    init(firstStep: String) {
        let steps = readSteps()
        self.steps = steps
        self.currentQuestionID = generateID(stepID: firstStep, questionID: (steps.first!.id))
    }


    func handleAnswerForYesNo(answer: Bool) {
        print("handleAnswerForYesNo ->")
        
        if currentQuestionID == summaryStepID || currentQuestionID == lastQuestionID{
            currentQuestionID = lastQuestionID
            print("-")
            return
        }
        
        
        let (cstep, cc) = getStepAndQuestion(id: currentQuestionID)

        if let yn = cc.yesno {

            if answer {
                switch yn.yes.result {
                case .askAnother:
                    
                    currentQuestionID = generateID(stepID: cstep.id, questionID: yn.yes.nextQuestion)
                    return
                case .pass:
                    passNum += 1
                    stepNum += 1
                    Log.debug("\(currentQuestionID) *pass passNum = \(passNum)")
                    break
                case .fail:
                    failNum += 1
                    stepNum += 1
                    Log.debug("*fail")
                    break
                default:
                    Log.debug("defult")
                    break
                }
            } else {
                switch yn.no.result {
                case .askAnother:
                    currentQuestionID = generateID(stepID: cstep.id, questionID: yn.no.nextQuestion)
                    return
                case .pass:
                    passNum += 1
                    stepNum += 1
                    Log.debug("*pass")
                    break
                case .fail:
                    failNum += 1
                    stepNum += 1
                    Log.debug("*fail")
                    break
                default:
                    Log.debug("defult")

                    break
                }
            }
        }
        
        
        let cindex = steps.index(of: cstep)!
        if cindex + 1 >= steps.count {
            //Completed
            print("cindex Completed")
            currentQuestionID = "sum"
            return
        }
        let nextStep = steps[cindex + 1]
        currentQuestionID = generateID(stepID: nextStep.id, questionID: nextStep.firstQuestion)

    }

    func handleAnswerForGroupQuestion(Results: ORKStepResult) {
        //Log.debug("handleAnswerForGroupQuestion \(Results)")
        print("handleAnswerForGroupQuestion id =",currentQuestionID)
        
        if currentQuestionID == summaryStepID || currentQuestionID == lastQuestionID{
            currentQuestionID = lastQuestionID
            print("-")
            return
        }

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
                
                if let boolenAnswer = bqr.booleanAnswer{
                    let answer = boolenAnswer == 1
                    if let groupName = cc.group!.questions[qNum] {
                        let a = GroupAnswer(id: qNum, answer: answer, groupName: groupName)
                        groupAnswers.append(a)
                        
                    } else {
                        let a = GroupAnswer(id: qNum, answer: answer, groupName: "")
                        groupAnswers.append(a)
                        
                    }
                }else{
                    return
                }
            }
        }
        
        

        if let qs = cc.group?.query {
            for q in qs {
                if let queryResult = runQuery(query: q, answers: groupAnswers) {

                    switch queryResult {
                    case .askAnother:
                        currentQuestionID = generateID(stepID: cstep.id, questionID: q.nextQuestion)
                        return
                    case .pass:
                        passNum += 1
                        stepNum += 1
                        Log.debug("current id = \(currentQuestionID) *pass of Group passNum = \(passNum)")
                        nextStep(with: cstep)
                        return
                    case .fail:
                        failNum += 1
                        stepNum += 1
                        Log.debug("current id = \(currentQuestionID) *fail of Group failNum = \(failNum)")
                        nextStep(with: cstep)
                        return
                    default:
                        Log.debug("default of Group")
                        break
                    }
                }
            }
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
            case .twoOrMoreYes:
                if twoOrMoreYes(groupAnswers: answerofGroup) {
                    return query.result
                }
            default:
                break
            }
        }
        return nil
    }

    func isGroup(id: String) -> Bool {

        let (_, qNum) = getStepAndQuestion(id: id)
        if qNum.group != nil {
            return true
        }
        return false
    }
    func isYesNoQuestion(id: String) -> Bool {

        let (_, qNum) = getStepAndQuestion(id: id)
        if qNum.yesno != nil {
            return true
        }
        return false
    }

}
