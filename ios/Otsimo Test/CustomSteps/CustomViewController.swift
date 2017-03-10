//
//  CustomViewController.swift
//  OtsimoTest
//
//  Created by demirci on 10/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//


import Foundation
import ResearchKit

class CustomViewController: ORKStepViewController {
    
    @IBOutlet var no_btn: UIButton!
    @IBOutlet var yes_btn: UIButton!
    var savedResult: ORKStepResult?
    
    override var result: ORKStepResult?{
        if let sr=savedResult{
            return sr
        }
        return super.result
    }
    
    var answer: String?
    override init(step: ORKStep, result: ORKResult?) {
        super.init(step: step, result: result!)
    }
    
    @IBOutlet var questionText: UILabel!
    override init(step: ORKStep?) {
        super.init(step: step)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "CustomStepVC", bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.loadView()
        questionText.text = step?.text
    }
    
    override func hasNextStep() -> Bool {
        return true
    }
    
    @IBAction func YesTapped(_ sender: UIButton) {
        let n = ORKBooleanQuestionResult(identifier: step!.identifier)
        n.booleanAnswer = 1
        savedResult = ORKStepResult(stepIdentifier: step!.identifier, results: [n])
        
    }
    
    @IBAction func NoTapped(_ sender: UIButton) {
        let n = ORKBooleanQuestionResult(identifier: step!.identifier)
        n.booleanAnswer = 0
        savedResult = ORKStepResult(stepIdentifier: step!.identifier, results: [n])
    }
    
    override func goForward() {
        super.goForward()
        
    }
    @IBAction func NextTapped(_ sender: Any) {
        self.goForward()
    }
}

