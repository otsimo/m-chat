//
//  ORKFormStep+Result.swift
//  OtsimoTest
//
//  Created by demirci on 07/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//


import ResearchKit



extension ORKStep {
    
    func instantiateDefaultStepResult(_ answerMap: NSDictionary?) -> ORKStepResult {
        return ORKStepResult(stepIdentifier: self.identifier, results: nil)
    }
}

extension ORKFormStep {
    override func instantiateDefaultStepResult(_ answerMap: NSDictionary?) -> ORKStepResult {
        let results = self.formItems?.mapAndFilter({ (formItem) -> ORKResult? in
            return formItem.instantiateQuestionResult(.defaultValue, answer: answerMap?[formItem.identifier] as AnyObject?)
        })
        return ORKStepResult(stepIdentifier: self.identifier, results: results)
    }
}

extension ORKActiveStep {
    override func instantiateDefaultStepResult(_ answerMap: NSDictionary?) -> ORKStepResult {
        // add a result to the step (there should be *something* to show)
        let activeResult = ORKFileResult(identifier: "file")
        return ORKStepResult(stepIdentifier: self.identifier, results: [activeResult])
    }
}

extension ORKPageStep {
    override func instantiateDefaultStepResult(_ answerMap: NSDictionary?) -> ORKStepResult {
        
        var results: [ORKResult] = []
        
        let taskResult = ORKTaskResult(taskIdentifier: self.identifier, taskRun: NSUUID() as UUID, outputDirectory: nil)
        taskResult.results = []
        
        var previousStepIdentifier: String? = nil
        while let step = self.stepAfterStep(withIdentifier: previousStepIdentifier, with: taskResult) {
            previousStepIdentifier = step.identifier
            let stepResult = step.instantiateDefaultStepResult(answerMap)
            taskResult.addResult(stepResult)
            if let stepResults = stepResult.results {
                results += stepResults.map({ (result) -> ORKResult in
                    let copy = result.copy() as! ORKResult
                    copy.identifier = "\(step.identifier).\(result.identifier)"
                    return copy
                })
            }
        }
        
        let stepResult = ORKStepResult(stepIdentifier: self.identifier, results: results)
        let pageVC = self.instantiateStepViewController(with: stepResult)
        let mutatedResult = pageVC.result
        
        return mutatedResult ?? stepResult
    }
}

protocol QuestionResultMapping {
    var questionType: ORKQuestionType { get }
    func instantiateQuestionResult(_ identifier: String, _ defaultAnswer: DefaultFormItemAnswer, _ answer: AnyObject?) -> ORKQuestionResult?
}

extension ORKFormItem {
    
    // Convenience method for adding a default answer or mapped answer for a given form item
    func instantiateQuestionResult(_ defaultAnswer: DefaultFormItemAnswer, answer: AnyObject?) -> ORKQuestionResult? {
        
        let impliedAnswerFormat = self.answerFormat?.implied()
        print("\(self.identifier): \(impliedAnswerFormat)")
        guard let answerFormat = impliedAnswerFormat as? SBAQuestionResultMapping,
            let questionResult = answerFormat.instantiateQuestionResult(self.identifier, defaultAnswer, answer)
            else {
                return nil
        }
        questionResult.questionType = answerFormat.questionType
        return questionResult
    }
}

extension ORKTextAnswerFormat: QuestionResultMapping {
    func instantiateQuestionResult(_ identifier: String, _ defaultAnswer: SBADefaultFormItemAnswer, _ answer: AnyObject?) ->ORKQuestionResult? {
        guard let str = answer as? String else { return nil }
        let result = ORKTextQuestionResult(identifier: identifier)
        result.textAnswer = str
        return result
    }
}

extension ORKDateAnswerFormat: QuestionResultMapping {
    func instantiateQuestionResult(_ identifier: String, _ defaultAnswer: SBADefaultFormItemAnswer, _ answer: AnyObject?) ->ORKQuestionResult? {
        guard let date = answer as? Date else { return nil }
        let result = ORKDateQuestionResult(identifier: identifier)
        result.dateAnswer = date
        return result
    }
}

protocol TextChoicesAnswerFormat: QuestionResultMapping {
    var textChoices: [ORKTextChoice] { get }
}

extension ORKValuePickerAnswerFormat: TextChoicesAnswerFormat {
}

extension ORKTextChoiceAnswerFormat: TextChoicesAnswerFormat {
}

extension TextChoicesAnswerFormat {
    
    func instantiateQuestionResult(_ identifier: String, _ defaultAnswer: DefaultFormItemAnswer, _ answer: AnyObject?) -> ORKQuestionResult? {
        
        // Exit early if there are no choices
        guard self.textChoices.count > 0 else { return nil }
        
        // Check that the answer is formatted as an array
        var choiceAnswers = answer as? [AnyObject]
        if choiceAnswers == nil && answer != nil {
            choiceAnswers = [answer!]
        }
        
        // Check that the choice answers are nil or valid
        guard (choiceAnswers == nil) || isValidAnswer(choiceAnswers! as AnyObject) else {
            assertionFailure("\(answer) is invalid")
            return nil
        }
        
        let result = ORKChoiceQuestionResult(identifier: identifier)
        if choiceAnswers != nil {
            result.choiceAnswers = choiceAnswers
        }
        else {
            switch defaultAnswer {
            case .first, .defaultValue:
                result.choiceAnswers = [self.textChoices.first!.value]
            case .last:
                result.choiceAnswers = [self.textChoices.last!.value]
            case .skip:
                result.choiceAnswers = nil
            }
        }
        
        return result
    }
    
    func isValidAnswer(_ answer: AnyObject) -> Bool {
        guard let choiceAnswers = answer as? [NSObject] else {
            return false
        }
        let filteredChoices = self.textChoices.filter ({ (textChoice) -> Bool in
            guard let value = textChoice.value as? NSObject else { return false }
            return choiceAnswers.contains(value)
        })
        return filteredChoices.count == choiceAnswers.count
    }
}

extension ORKScaleAnswerFormat : QuestionResultMapping {
    
    func instantiateQuestionResult(_ identifier: String, _ defaultAnswer: DefaultFormItemAnswer, _ answer: AnyObject?) -> ORKQuestionResult? {
        
        let result = ORKScaleQuestionResult(identifier: identifier)
        if let num = answer as? NSNumber {
            result.scaleAnswer = num
        }
        else {
            switch defaultAnswer {
            case .defaultValue:
                result.scaleAnswer = self.defaultValue as NSNumber?
            case .first:
                result.scaleAnswer = self.minimum as NSNumber?
            case .last:
                result.scaleAnswer = self.maximum as NSNumber?
            case .skip:
                result.scaleAnswer = nil
            }
        }
        
        return result
    }
    
}
