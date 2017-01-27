//
//  ViewController.swift
//  Otsimo Test
//
//  Created by demirci on 29/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//

import UIKit
import ResearchKit
import SwiftProtobuf
import PopupDialog



class ViewController: UIViewController {

    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?

    @IBOutlet weak var label_passNum: UILabel!
    @IBOutlet weak var label_failNum: UILabel!
    var isRun = 0
    var taskResult: ORKTaskResult?
    var iResult = Otsimo_Info()
    override func viewDidAppear(_ animated: Bool) {
        
        
        Log.debug("ViewController : viewDidAppear")
        let anlyse = Analyse()
        if isRun == 0 {
            Log.debug("isRun 0")
            present(consentTaskVC, animated: true, completion: nil)
            isRun = 1
        } else if isRun == 1 {
            Log.debug("isRun 1")
            present(infoTaskVC, animated: true, completion: nil)
            isRun = 2
        } else if isRun == 2 {
            Log.debug("isRun 2")
            if let t = taskResult{
                iResult = anlyse.InfoResult(infoResult: t)
            }
            present(taskViewContoller, animated: true, completion: nil)
            isRun = 3
        } else if isRun == 3 {
            if let t = taskResult{
                
                let surveyResults = anlyse.Task(result: t)
                print("surveyResult", surveyResults)
                
                let analysedResult = anlyse.getAnalyzedResult(iresult: iResult, sresults: surveyResults)
                //Convert analysedResult to json
                do {
                    let json = try analysedResult.serializeJSON()
                    print("json-----> \(json)")
                    
                    //And Send Result to Server
                    let server = Server()
                    let response = server.sendResult(json: json)
                    Log.debug(response)
                    
                } catch let e {
                    Log.error(e as! String)
                }
                
                showResultScene(passNum: pollster.passNum, failNum: pollster.failNum)
                label_passNum.text = "PASS NUM = " + String(pollster.passNum)
                label_failNum.text = "FAİL NUM = " + String(pollster.failNum)
            }
        }
    }

    func showResultScene(passNum : Int, failNum : Int){
        
        
        if (failNum >= 0 && failNum <= 2){
            print("LOW RİSK")
            
            let resultVC = HighResultPopupController(nibName: "LowResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
            
            // Create second button
            let buttonSave = DefaultButton(title: "Save") {
                print("You ok'd the default dialog")
            }
            buttonSave.backgroundColor = UIColor(red:0.30, green:0.65, blue:0.24, alpha:1.0)
            buttonSave.titleColor = UIColor.white
            
            let buttonShare = DefaultButton(title: "Share") {
                print("share")
            }
            
            buttonShare.backgroundColor = UIColor(red:0.30, green:0.65, blue:0.24, alpha:1.0)
            buttonShare.titleColor = UIColor.white
            
            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
            
        }else if (failNum >= 3 && failNum <= 7){
            print("MEDIUM RİSK")
            let resultVC = HighResultPopupController(nibName: "MediumResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
            
            // Create second button
            let buttonSave = DefaultButton(title: "Save") {
                print("You ok'd the default dialog")
            }
            buttonSave.backgroundColor = UIColor(red:0.30, green:0.65, blue:0.24, alpha:1.0)
            buttonSave.titleColor = UIColor.white
            
            let buttonShare = DefaultButton(title: "Share") {
                print("share")
            }
            
            buttonShare.backgroundColor = UIColor(red:0.30, green:0.65, blue:0.24, alpha:1.0)
            buttonShare.titleColor = UIColor.white
            
            // Add buttons to dialog
            popupVC.addButtons([buttonSave,buttonShare])
            present(popupVC, animated: true, completion: nil)
        }else if (failNum >= 8 && failNum <= 20){
            print("HIGH RİSK")
            let resultVC = HighResultPopupController(nibName: "HighResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
            
            // Create second button
            let buttonSave = DefaultButton(title: "Save") {
                print("You ok'd the default dialog")
            }
            buttonSave.backgroundColor = UIColor(red:0.30, green:0.65, blue:0.24, alpha:1.0)
            buttonSave.titleColor = UIColor.white
            
            let buttonShare = DefaultButton(title: "Share") {
                print("share")
            }
            
            buttonShare.backgroundColor = UIColor(red:0.30, green:0.65, blue:0.24, alpha:1.0)
            buttonShare.titleColor = UIColor.white
            
            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        }
    
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        Log.debug("ViewController : viewWillAppear")

    }
    var pollster = Pollster(firstStep: "1")


    lazy var taskViewContoller: ORKTaskViewController = {
        let taskViewController = ORKTaskViewController(task: SurveyTask(self.pollster), taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] , isDirectory: true) as URL
        return taskViewController
    }()

    lazy var consentTaskVC: ORKTaskViewController = {
        let consentTaskVC = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        consentTaskVC.delegate = self
        return consentTaskVC
    }()

    lazy var infoTaskVC: ORKTaskViewController = {
        let infoTaskVC = ORKTaskViewController(task: InfoTask, taskRun: nil)
        infoTaskVC.delegate = self
        return infoTaskVC
    }()


    override func viewDidLoad() {
        print("*")
        super.viewDidLoad()
        Log.debug("ViewController : viewDidLoad")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
