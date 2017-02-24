//
//  QuestionTableViewCell.swift
//  OtsimoTest
//
//  Created by demirci on 24/02/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import UIKit
import ResearchKit

protocol QuestionTableViewCellDelegate: class {
    func didChangeAnswer(cell: QuestionTableViewCell)
}


class QuestionTableViewCell: UITableViewCell {

    static let reuseIdentifier = "questionCell"
    
    weak var delegate: QuestionTableViewCellDelegate?
    
    @IBOutlet weak var preferredHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBAction func leftButtonTapped(_ sender: AnyObject) {
        self.choiceAnswer = leftAnswer
    }
    
    @IBAction func rightButtonTapped(_ sender: AnyObject) {
        self.choiceAnswer = rightAnswer
    }
    
    var result: ORKResult?
    
    var hasAnswer: Bool {
        return self.choiceAnswer != nil
    }
    
    private var choiceAnswer: Any? {
        didSet {
            
            // Update buttons
            updateTintColor()
            
            // update the associated result
            if let choiceResult = result as? ORKChoiceQuestionResult {
                choiceResult.choiceAnswers = {
                    guard let choice = self.choiceAnswer else { return nil }
                    return [choice]
                }()
            }
            else if let boolResult = result as? ORKBooleanQuestionResult {
                boolResult.booleanAnswer = choiceAnswer as? NSNumber
            }
            
            // send delegate message that the cell answer did change
            self.delegate?.didChangeAnswer(cell: self)
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        updateTintColor()
    }
    
    func updateTintColor() {
        self.leftButton.setTitleColor(SBAObjectNonNilEquality(choiceAnswer, leftAnswer) ? self.tintColor : UIColor.lightGray, for: .normal)
        self.rightButton.setTitleColor(SBAObjectNonNilEquality(choiceAnswer, rightAnswer) ? self.tintColor : UIColor.lightGray, for: .normal)
    }
    
    private var answerFormat: ORKTextChoiceAnswerFormat?
    
    private var leftAnswer: Any? {
        return self.answerFormat?.textChoices.first?.value
    }
    
    private var rightAnswer: Any? {
        return self.answerFormat?.textChoices.last?.value
    }
    
    func configure(formItem: ORKFormItem, stepResult: ORKStepResult?) {
        self.questionLabel.text = formItem.text
        
        // Get the initial result
        let initialResult = stepResult?.result(forIdentifier: formItem.identifier)
        
        // Setup for types that this cell can handle
        if let format = formItem.answerFormat as? ORKTextChoiceAnswerFormat {
            self.answerFormat = format
            self.result = initialResult ?? ORKChoiceQuestionResult(identifier: formItem.identifier)
        }
        else if let _ = formItem.answerFormat as? ORKBooleanAnswerFormat {
            self.answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: [
                ORKTextChoice(text: NSLocalizedString("buttonYes", comment: ""), value: NSNumber(value: true)),
                ORKTextChoice(text: NSLocalizedString("buttonNo", comment: ""), value: NSNumber(value: false))
                ])
            self.result = initialResult ?? ORKBooleanQuestionResult(identifier: formItem.identifier)
        }
        else {
            assertionFailure("\(formItem.answerFormat) is not supported")
        }
        
        // Set the currently selected answer
        self.choiceAnswer = {
            if let choiceResult = initialResult as? ORKChoiceQuestionResult {
                return choiceResult.choiceAnswers?.first
            }
            else if let boolResult = initialResult as? ORKBooleanQuestionResult {
                return boolResult.booleanAnswer
            }
            return nil
        }()
        
        // Set the button titles
        self.leftButton.setTitle(self.answerFormat?.textChoices.first?.text, for: .normal)
        self.rightButton.setTitle(self.answerFormat?.textChoices.last?.text, for: .normal)
    }
    
}
