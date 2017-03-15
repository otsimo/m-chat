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
     Tells the delegate that a step view controller is about to be displayed.
     
     The task view controller calls this method before presenting the step
     view controller.
     
     This method gives you an opportunity to modify the step view controller before presentation.
     For example, you might want to modify the `learnMoreButtonTitle` or `continueButtonTitle`
     properties, or modify other button state. Another possible use case is when a particular
     step view controller requires additional setup before presentation.
     
     @param taskViewController  The calling `ORKTaskViewController` instance.
     @param stepViewController  The `ORKStepViewController` that is about to be displayed.
     */
    public func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {

    }










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
        taskViewController.dismiss(animated: true, completion: nil)


        switch reason {

        case .completed:
            Log.debug("task completed")
            taskViewCompleted(taskViewController: taskViewController)

        case .failed:
            Log.debug("failed")
        case .discarded:
            Log.debug("discarded")

            taskViewDiscarded(taskViewController: taskViewController)

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

        Log.debug("taskViewController dissmissed")


    }

    //If didFinishWith reason is completed, then
    func taskViewCompleted(taskViewController: ORKTaskViewController) {
        taskResult = taskViewController.result
        analytics.event("completed", data: [:])


        switch taskViewController.result.identifier {
        case Tasks.consentTaskID:
            analytics.event("completedConsent", data: [:])
            present(infoTaskVC, animated: true, completion: nil)

        case Tasks.infoTaskID:
            analytics.event("completedInfo", data: [:])
            present(mChatVC, animated: true, completion: nil)
            if let t = taskResult {
                iResult = anlyse.InfoResult(infoResult: t)
            }
        case Tasks.mChatTaskID:
            analytics.event("completed-mChat", data: [:])
            print("mChat Task Result:",taskResult)
            showResultScene(passNum: 20, failNum: 1)
        case Tasks.mChatRFTaskID:
            analytics.event("completed-mChatRF", data: [:])
            if let t = taskResult {

                let surveyResults = anlyse.Task(result: t)
                print("surveyResult", surveyResults)

                let analysedResult = anlyse.getAnalyzedResult(iresult: iResult, sresults: surveyResults)
                //Convert analysedResult to json
                do {
                    resultJSON = try analysedResult.serializeJSON()
                    Log.debug(resultJSON)
                    //And Send Result to Server
                    let server = Server()
                    let response = server.sendResult(json: resultJSON)
                    Log.debug(response)

                } catch let e {
                    Log.error(e as! String)
                }

                showResultScene(passNum: pollster.passNum, failNum: pollster.failNum)

            }
        default:
            break
        }

    }
    
    func taskViewDiscarded(taskViewController : ORKTaskViewController){
        if let results = taskViewController.result.results {
            if let lastStep = results.last {
                let discardedID = lastStep.identifier
                let startDate = Int64(lastStep.startDate.timeIntervalSince1970)
                let endDate = Int64(lastStep.endDate.timeIntervalSince1970)
                Log.debug("analytics id = \(discardedID) , startDate = \(startDate), endDate = }(endDate)")
                
                switch taskViewController.result.identifier {
                case Tasks.consentTaskID:
                    analytics.event("discardedConsent", data: ["id": discardedID, "startDate": startDate, "endDate": endDate])
                    present(infoTaskVC, animated: true, completion: nil)
                case Tasks.infoTaskID:
                    analytics.event("discardedInfo", data: ["id": discardedID, "startDate": startDate, "endDate": endDate])
                    present(mChatVC, animated: true, completion: nil)
                    if let t = taskResult {
                        iResult = anlyse.InfoResult(infoResult: t)
                    }
                case Tasks.mChatRFTaskID:
                    analytics.event("discardedSurvey", data: ["id": discardedID, "startDate": startDate, "endDate": endDate])
                default:
                    break
                }
                
            }
        }
    }
    
    func taskViewSaved(taskViewController: ORKTaskViewController){
        if let results = taskViewController.result.results {
            if let lastStep = results.last {
                let discardedID = lastStep.identifier
                let startDate = Int64(lastStep.startDate.timeIntervalSince1970)
                let endDate = Int64(lastStep.endDate.timeIntervalSince1970)
                Log.debug("analytics id = \(discardedID) , startDate = \(startDate), endDate = }(endDate)")
                
                switch taskViewController.result.identifier {
                case Tasks.infoTaskID:
                    analytics.event("savedInfo", data: ["id": discardedID, "startDate": startDate, "endDate": endDate])
                case Tasks.mChatRFTaskID:
                    analytics.event("savedSurvey", data: ["id": discardedID, "startDate": startDate, "endDate": endDate])
                    
                    let savedData = taskViewController.restorationData
                    
                    let userDefaults = UserDefaults.standard
                    userDefaults.setValue(savedData, forKey: "restorationDataForSurvey")
                    let lastQuestionID = lastStep.identifier
                    userDefaults.set(lastQuestionID, forKey: "lastQuestionIdOfRestoration")
                    print("*****lastQuestionID ->", lastQuestionID)
                case Tasks.mChatTaskID: break
                default:
                    break
                }
                
            }
        }

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
    public func taskViewControllerSupportsSaveAndRestore(_ taskViewController: ORKTaskViewController) -> Bool {
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
    public func taskViewControllerShouldConfirmCancel(_ taskViewController: ORKTaskViewController) -> Bool {
        Log.debug("taskViewControllerShouldConfirmCancel")
        return true
    }




}
