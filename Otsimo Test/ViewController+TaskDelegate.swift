//
//  ViewController+TaskDelegate.swift
//  OtsimoTest
//
//  Created by demirci on 15/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit


extension ViewController: ORKTaskViewControllerDelegate {
    /**
     Tells the delegate that the task has finished.
     
     The task view vartroller calls this method when an unrecoverable error occurs,
     when the user has canceled the task (with or without saving), or when the user
     completes the last step in the task.
     
     In most circumstances, the receiver should dismiss the task view controller
     in response to this method, and may also need to collect and process the results
     of the task.
     
     @param taskViewController  The `ORKTaskViewController `instance that is returning the result.
     @param reason              An `ORKTaskViewControllerFinishReason` value indicating how the user chose to complete the task.
     @param error               If failure occurred, an `NSError` object indicating the reason for the failure. The value of this parameter is `nil` if `result` does not indicate failure.
     */
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        print("didFinishWithReason \(reason)")
        switch reason {
            
        case .completed:
            Log.debug("completed")
             taskResult = taskViewController.result
            print(taskResult)
        case .failed:
            Log.debug("failed")
        case .discarded:
            Log.debug("discarded")
        case .saved:
            Log.debug("saved")
        }
        /*
         The `reason` passed to this method indicates why the task view
         controller finished: Did the user cancel, save, or actually complete
         the task; or was there an error?
         
         The actual result of the task is on the `result` property of the task
         view controller.
         */
        taskResultFinishedCompletionHandler?(taskViewController.result)
        print("passNum-> ",pollster.passNum)
        print("failNum->",pollster.failNum)
        taskViewController.dismiss(animated: true, completion: nil)
        consentTaskVC.dismiss(animated: true, completion: nil)
        infoTaskVC.dismiss(animated: true, completion: nil)
        Log.debug("taskViewController dissmissed")

        
    }
    /**
     Asks the delegate if the state of the current uncompleted task should be saved.
     
     The task view controller calls this method to determine whether to offer
     a save option when the user attempts to cancel a task that is in progress.
     
     If this method is not implemented, the task view controller assumes that save and restore are not supported.
     If this method returns `YES`, it's recommended that you copy the value of the `restorationData` property of the
     task view controller and pass that data to `initWithTask:restorationData:` when it is time
     to create a new task view controller to continue from the point at which the user stopped.
     
     @param taskViewController  The calling `ORKTaskViewController` instance.
     
     @return `YES` if save and restore should be supported; otherwise, `NO`.
     */
    public func taskViewControllerSupportsSaveAndRestore(_ taskViewController: ORKTaskViewController) -> Bool{
        Log.debug("taskViewControllerSupportsSaveAndRestore")

        //pollster.currentQuestionID = "0:0"
        //        self.taskViewContoller.suspend()
        //self.taskViewContoller.dismiss(animated: true, completion: nil)
        return true
    }
    
    
    /**
     Asks the delegate if the cancel action should be confirmed
     
     The task view controller calls this method to determine whether or not to confirm
     result save or discard when user attempts to cancel a task that is in progress.
     
     If this method is not implemented, the task view controller assumes that cancel should be confirmed.
     If this method returns `YES`, then cancel action will be confirmed.
     If this method returns `NO`, then the results will immediately be discarded.
     
     @param taskViewController  The calling `ORKTaskViewController` instance.
     
     @return `YES` to confirm cancel action; `NO` to immediately discard the results.
     */
    public func taskViewControllerShouldConfirmCancel(_ taskViewController: ORKTaskViewController) -> Bool{
        Log.debug("taskViewControllerShouldConfirmCancel")
        return true
    }
    
    
    
    
}
