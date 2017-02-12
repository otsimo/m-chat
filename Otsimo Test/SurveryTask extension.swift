//
//  SurveryTask extension.swift
//  OtsimoTest
//
//  Created by demirci on 30/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit

extension SurveyTask {
    func getYesNoStep(with id: String) -> ORKStep {
        let q = manager.getQuestion(id: id)
        let step = ORKQuestionStep(identifier: manager.currentQuestionID, title: q.text, answer: .booleanAnswerFormat())
        step.isOptional = false
        return step
    }
    func getGroupStep(with id: String) -> ORKStep {
        let q = manager.getQuestion(id: id)
        let title = NSLocalizedString(getLocalizedID(id: id), comment: "")
        let step = ORKFormStep(identifier: id, title: title, text: "")
        step.formItems = []
        step.isOptional = false
        for gq in (q.group?.questions)! {

            let s = parseID(id: id).0

            let gqID = s + ":" + String(gq.key)
            let text = NSLocalizedString(getLocalizedID(id: gqID), comment: "")
            let stepItem = ORKFormItem(identifier: gqID, text: text, answerFormat: .booleanAnswerFormat())
            stepItem.isOptional = false
            stepItem.accessibilityNavigationStyle = .combined

            step.formItems? = (step.formItems)! + [stepItem]
        }
        step.accessibilityNavigationStyle = .combined
        return step

    }
    func getSummaryStep() -> ORKStep {
        let summaryStep = ORKCompletionStep(identifier: "custom")
        summaryStep.title = NSLocalizedString("summaryStep.title", comment: "")
        summaryStep.text = NSLocalizedString("We appreciate your time.", comment: "")
        return summaryStep
    }

}
