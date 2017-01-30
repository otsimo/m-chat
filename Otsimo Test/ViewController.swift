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
     let anlyse = Analyse()
    override func viewDidAppear(_ animated: Bool) {


        Log.debug("ViewController : viewDidAppear")

            //present(consentTaskVC, animated: true, completion: nil)
        present(taskViewContoller,animated: true,completion:nil)
    }

    func showResultScene(passNum: Int, failNum: Int) {


        if (failNum >= 0 && failNum <= 2) {
            print("LOW RİSK")

            let resultVC = HighResultPopupController(nibName: "LowResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Create second button
            let buttonSave = DefaultButton(title: "Save") {
                print("You ok'd the default dialog")
            }
            buttonSave.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
            buttonSave.titleColor = UIColor.white

            let buttonShare = DefaultButton(title: "Share") {
                print("share")
            }

            buttonShare.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
            buttonShare.titleColor = UIColor.white

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)

        } else if (failNum >= 3 && failNum <= 7) {
            print("MEDIUM RİSK")
            let resultVC = HighResultPopupController(nibName: "MediumResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Create second button
            let buttonSave = DefaultButton(title: "Save") {
                print("You ok'd the default dialog")
            }
            buttonSave.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
            buttonSave.titleColor = UIColor.white

            let buttonShare = DefaultButton(title: "Share") {
                print("share")
            }

            buttonShare.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
            buttonShare.titleColor = UIColor.white

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        } else if (failNum >= 8 && failNum <= 20) {
            print("HIGH RİSK")
            let resultVC = HighResultPopupController(nibName: "HighResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Create second button
            let buttonSave = DefaultButton(title: "Save") {
                print("You ok'd the default dialog")
            }
            buttonSave.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
            buttonSave.titleColor = UIColor.white

            let buttonShare = DefaultButton(title: "Share") {
                print("share")
            }

            buttonShare.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
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

        if let restorationData = UserDefaults.standard.data(forKey: "restorationDataForSurvey") {
            print("restorationData")
            if let restorationStepID = UserDefaults.standard.string(forKey: "lastQuestionIdOfRestoration"){
                print("restorationStepID ->",restorationStepID)
                let id = String(describing: restorationStepID)
                var restorationPollster = Pollster(firstStep: id)
                let taskViewController = ORKTaskViewController(task: SurveyTask(restorationPollster), restorationData: restorationData, delegate: self)
                return taskViewController
            }
           
        }
        let taskViewController = ORKTaskViewController(task: SurveyTask(self.pollster), taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true) as URL
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
        print("didReceiveMemoryWarning")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("viewWillDisappear")

        let savedData = taskViewContoller.restorationData

        let userDefaults = UserDefaults.standard
        userDefaults.setValue(savedData, forKey: "restorationDataForSurvey")
    }


}
