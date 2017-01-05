//
//  SurveyTask+StepFunctions.swift
//  OtsimoTest
//
//  Created by demirci on 05/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit

extension SurveyTask{

    
    
    
    
    func askQuestion(text: String) -> Bool {
        //TO DO ASKQuestion
        let q  = ORKQuestionStep(identifier: text, title: text, answer: ORKBooleanAnswerFormat())
        
        
        
        return answers["yesno"] == YesAnswer
    }
    
    
    
    func getQuestion(step: Otsimo_Mchat_Step, id: String) -> Otsimo_Mchat_Question? {
        for q in step.questions {
            if q.id == id {
                return q
            }
        }
        return nil
    }
    class groupResult {
        var question: Int?
        var group: String?
        var result: Bool?
        
        init(q: Int, g: String, r: Bool) {
            self.question = q
            self.group = g
            self.result = r
        }
        func isGroupOK(want: String) -> Bool {
            if want == "" || want == "+" || want == "-" {
                return true
            }
            return want == group
        }
    }
    
    
    func finalize(step: Otsimo_Mchat_Step, res: Otsimo_Mchat_ResultType, next: String) -> Otsimo_Mchat_ResultType {
        
        switch res {
        case .askAnother:
            return executeQuestion(step: step, id: next)
        default:
            return res
        }
        
    }
    
    
    
    
    func executeGroup(step: Otsimo_Mchat_Step, group: Otsimo_Mchat_GroupQuestion) -> Otsimo_Mchat_ResultType {
        var theresults: [groupResult] = []
        
        for qs in group.questions {
            let id = String(qs.key)
            var q = getQuestion(step: step, id: id)
            if let t = q?.text{
                let res = askQuestion(text: t)
                theresults.append(groupResult(q: Int(qs.key), g: qs.value, r: res))
                
            }
        }
        
        
        for query in group.query {
            for action in query.actions {
                switch action {
                case .allOfYes:
                    var ok = true
                    for r in theresults {
                        if r.isGroupOK(want: query.group){
                            if !r.result!{
                                ok = false
                            }
                        }
                    }
                    if ok {
                        return finalize(step: step, res: query.result, next: query.nextQuestion)
                    }
                    
                case .allOfNo:
                    var ok = true
                    for r in theresults {
                        if r.isGroupOK(want: query.group){
                            if r.result!{
                                ok = false
                            }
                        }
                    }
                    if ok {
                        return finalize(step: step, res: query.result, next: query.nextQuestion)
                    }
                case .mostOftenNo:
                    var nos = 0
                    var yeses = 0
                    for q in theresults{
                        if q.isGroupOK(want: query.group){
                            if q.result!{
                                yeses += 1
                            }else {
                                nos += 1
                            }
                        }
                    }
                    if nos > yeses{
                        return finalize(step: step, res: query.result, next: query.nextQuestion)
                    }
                case .mostOftenYes:
                    var nos = 0
                    var yeses = 0
                    for q in theresults{
                        if q.isGroupOK(want: query.group){
                            if q.result!{
                                yeses += 1
                            }else {
                                nos += 1
                            }
                        }
                    }
                    if nos < yeses{
                        return finalize(step: step, res: query.result, next: query.nextQuestion)
                    }
                case .oneOfNo:
                    for q in theresults{
                        if q.isGroupOK(want: query.group){
                            if !q.result!{
                                return finalize(step: step, res: query.result, next: query.nextQuestion)
                            }
                        }
                    }
                case .oneOfYes:
                    for q in theresults{
                        if q.isGroupOK(want: query.group){
                            if q.result!{
                                return finalize(step: step, res: query.result, next: query.nextQuestion)
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    func executeQuestion(step: Otsimo_Mchat_Step, id: String) -> Otsimo_Mchat_ResultType {
        if let q = getQuestion(step: step, id: id) {
            
            if let group = q.group {
                if (q.text) != "" {
                    print(q.text)
                }
                return executeGroup(step: step, group: group)
            } else if let yesno = q.yesno {
                if askQuestion(text: q.text) {
                    return finalize(step: step, res: yesno.yes.result, next: yesno.yes.nextQuestion)
                } else {
                    return finalize(step: step, res: yesno.no.result, next: yesno.no.nextQuestion)
                }
            }
            
        }
        
    }
    
    
    func executeStep(step: Otsimo_Mchat_Step) -> Otsimo_Mchat_ResultType {
        let fq = step.firstQuestion
        
        return executeQuestion(step: step, id: fq)
    }
    
    
}
