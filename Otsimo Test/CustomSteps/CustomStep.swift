//
//  CustomStep.swift
//  OtsimoTest
//
//  Created by demirci on 10/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//


import Foundation
import ResearchKit

class CustomStep: ORKQuestionStep {
    
    override init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func stepViewControllerClass () -> CustomViewController.Type {
        return CustomViewController.self
    }
    
    
    
    
    
    func instantiateStepViewController(with result: ORKResult) -> ORKStepViewController? {
        let vc = CustomViewController(step: self, result: result)
        vc.delegate = self
        print("instantiateStepViewController : result ->",result)
        return vc
    }
    
    
}

extension CustomStep : ORKStepViewControllerDelegate{
    /**
     Tells the delegate when the user has done something that requires navigation, such as
     tap the Back or a Next button, or enter a response to a nonoptional
     survey question.
     
     @param stepViewController     The step view controller providing the callback.
     @param direction              Direction of navigation requested.
     */
    public func stepViewController(_ stepViewController: ORKStepViewController, didFinishWith direction: ORKStepViewControllerNavigationDirection){
        print("CustomStep : ORKStepViewControllerDelegate : didFinishWith")
    }
    
    
    /**
     Tells the delegate when a substantial change has occurred to the result.
     
     The result is always available in the step view controller. Although the result is continuously changing
     while the step view controller is active (because the time stamp in the result property is different each time it's called), this method is called only when a substantive change
     to the result occurs, such as when the user enters a survey answer or completes
     an active step.
     
     In your implementation of this delegate method, you can collect the value of `result` from the step view controller.
     
     @param stepViewController     The step view controller providing the callback.
     */
    public func stepViewControllerResultDidChange(_ stepViewController: ORKStepViewController){
        print("CustomStep : ORKStepViewControllerDelegate : stepViewControllerResultDidChange")
        
    }
    
    
    /**
     Tells the delegate when a step fails due to an error.
     
     A step view controller can use this method to report its failure to the task view controller.
     The task view controller sends the error to its delegate indicating that the task has failed (using `ORKTaskViewControllerFinishReasonFailed`).
     Note that recorder errors are reported by calling the `ORKStepViewControllerDelegate` method `stepViewController:recorder:didFailWithError:`.
     
     @param stepViewController     The step view controller providing the callback.
     @param error                  The error detected.
     */
    public func stepViewControllerDidFail(_ stepViewController: ORKStepViewController, withError error: Error?){
        print("CustomStep : ORKStepViewControllerDelegate : stepViewControllerDidFail")
        
    }
    
    
    /**
     Tells the delegate when a recorder error has been detected during the step.
     
     Recorder errors can occur during active steps, usually due to the
     unavailability of sensor data or disk space in which to record results.
     
     @param stepViewController     The step view controller providing the callback.
     @param recorder               The recorder that detected the error.
     @param error                  The error detected.
     */
    public func stepViewController(_ stepViewController: ORKStepViewController, recorder: ORKRecorder, didFailWithError error: Error){
        print("CustomStep : ORKStepViewControllerDelegate : didFailWithError")
        
    }
    
    
    
}

