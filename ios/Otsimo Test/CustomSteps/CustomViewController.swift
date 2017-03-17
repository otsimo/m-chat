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
    
    @IBOutlet weak var no_btn: UIButton!
    @IBOutlet weak var yes_btn: UIButton!
    @IBOutlet var nextButton: UIButton!
    var savedResult: ORKStepResult?
    let colorManager = ColorManager()
    
    
    override var result: ORKStepResult?{
        if let sr=savedResult{
            return sr
        }
        return super.result
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    var answer: Int?
    var startDate: Date?
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
        startDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
    }
    
    override func hasNextStep() -> Bool {
        return true
    }
    
    @IBAction func YesTapped(_ sender: UIButton) {
        answer = 1

        //Then change Yes Button Style
        yes_btn.setTitleColor(colorManager.selectedButtonColor, for: .normal)
        no_btn.setTitleColor(colorManager.normalButtonColor, for: .normal)
        nextButton.alpha = 1.0
        nextButton.isSelected = true
        nextButton.isEnabled = true
    }
    
    @IBAction func NoTapped(_ sender: UIButton) {
        answer = 0
        
        //Then change button styles
        no_btn.setTitleColor(colorManager.selectedButtonColor, for: .normal)
        yes_btn.setTitleColor(colorManager.normalButtonColor, for: .normal)
        nextButton.alpha = 1.0
        nextButton.isSelected = true
        nextButton.isEnabled = true
    }
    
    override func goForward() {
        super.goForward()
        
    }
    @IBAction func NextTapped(_ sender: Any) {
        let n = ORKBooleanQuestionResult(identifier: step!.identifier)
        n.booleanAnswer = answer as NSNumber?
        if let sDate = self.startDate{
            n.startDate = sDate
        }
        n.endDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        savedResult = ORKStepResult(stepIdentifier: step!.identifier, results: [n])
        self.goForward()
    }
    
}


