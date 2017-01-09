//
//  Pollster.swift
//  OtsimoTest
//
//  Created by demirci on 06/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit
func generateID(stepID: String, questionID: String) -> String {
    return stepID + ":" + questionID
}
func parseID(id: String) -> (String, String) {
    print("parseID ->", id)
    var idArray = id.components(separatedBy: ":")
    return (idArray[0], idArray[1])
}


public class Pollster {
    var currentQuestionID: String
    var currentStepID: String
    var lastQuestionID: String = "0"
    var steps: [Otsimo_Mchat_Step]

    init(steps: [Otsimo_Mchat_Step], firstStep: String) {
        self.steps = steps
        currentQuestionID = generateID(stepID: firstStep, questionID: (steps.first!.id))
        let ids = parseID(id: currentQuestionID)
        currentStepID = ids.0
    }

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

    func handleAnswerForYesNo(answer: Bool) {
        let ids = parseID(id: currentQuestionID)
        let stepNum = ids.0
        let qNum = ids.1

        for s in steps {
            if s.id == stepNum {
                for q in s.questions {
                    if q.id == qNum {
                        if let yn = q.yesno {

                            if answer {
                                if yn.yes.result == Otsimo_Mchat_ResultType.askAnother {
                                    currentQuestionID = generateID(stepID: stepNum, questionID: yn.yes.nextQuestion)
                                }
                            } else {
                                if yn.no.result == Otsimo_Mchat_ResultType.askAnother {
                                    currentQuestionID = generateID(stepID: stepNum, questionID: yn.no.nextQuestion)
                                }
                            }


                        } else if let group = q.group {
                            Log.debug("This is group")
                        }
                    }
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
        var parentQuestions: [String: String] = [:]
        var querys: [Otsimo_Mchat_Query] = []


        //Firstly we get questions parent having and query
        for s in steps {
            if s.id == parentStepNum {
                for q in s.questions {
                    if q.id == parentNum {

                        if let questions = q.group?.questions {
                            for pq in questions {
                                let qName = String(pq.key)
                                parentQuestions[qName] = pq.value
                            }
                        }
                        if let qrys = q.group?.query {
                            for q in qrys {
                                querys.append(q)
                            }
                        }


                    }
                }
            }
        }

        print("Parent Question \(parentQuestions)")
        //Secondly we get


        //Then Group Result
        var questionResults: [String: Bool] = [:]

        var passExampleYesNum = 0
        var passExampleNum = 0
        var failExampleYesNum = 0
        var failExampleNum = 0

        if let results = Results.results {
            for result in results {
                let bqr = result as! ORKBooleanQuestionResult
                let qID = bqr.identifier
                let qIDs = parseID(id: qID)
                let qNum = qIDs.1
                let answer = bqr.booleanAnswer == 1
                questionResults[qNum] = answer


                if parentQuestions[qNum] == "pass"{
                    passExampleNum += 1
                    if answer{
                        passExampleYesNum += 1
                    }
                } else if parentQuestions[qNum] == "fail"{
                    failExampleNum += 1
                    if answer{
                        failExampleYesNum += 1
                    }
                }
            }
        }

        print("question Results ** -> \(questionResults)")

        var result = Otsimo_Mchat_ResultType()
//
//        //and then queryActions
//        for query in querys {
//
//            if query.group != "pass" {
//                //Check Pass and Fail Examples
//                if query.actions[0] == Otsimo_Mchat_QueryType.allOfYes {
//                    if passExampleYesNum == passExampleNum{
//                        result = Otsimo_Mchat_ResultType.pass
//                    }
//
//                } else if query.actions[0] == Otsimo_Mchat_QueryType.allOfNo {
//                    if passExampleYesNum == passExampleNum{
//                        result = Otsimo_Mchat_ResultType.pass
//                    }
//                }
//
//            } else if query.group != "fail" {
//                //Check Pass and Fail Examples
//                if query.actions[0] == Otsimo_Mchat_QueryType.allOfYes {
//
//                } else if query.actions[0] == Otsimo_Mchat_QueryType.allOfNo {
//
//                }
//
//            }
//                else if query.actions[0] == Otsimo_Mchat_QueryType.allOfYes {
//
//            }
//                else if query.actions[0] == Otsimo_Mchat_QueryType.allOfNo {
//
//            }
//                else if query.actions[0] == Otsimo_Mchat_QueryType.mostOftenNo {
//
//            }
//                else if query.actions[0] == Otsimo_Mchat_QueryType.mostOftenYes {
//
//            }
//                else if query.actions[0] == Otsimo_Mchat_QueryType.oneOfYes {
//
//            }
//                else if query.actions[0] == Otsimo_Mchat_QueryType.oneOfNo {
//
//            }
//
//        }

    }


    func isGroup(id: String) -> Bool {
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNum = ids.1

        for s in steps {
            if s.id == stepNum {
                for q in s.questions {
                    if q.id == qNum {
                        if let grp = q.group {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    func isYesNoQuestion(id: String) -> Bool {
        let ids = parseID(id: id)
        let stepNum = ids.0
        let qNum = ids.1

        for s in steps {
            if s.id == stepNum {
                for q in s.questions {
                    if q.id == qNum {
                        if let yn = q.yesno {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }


}
