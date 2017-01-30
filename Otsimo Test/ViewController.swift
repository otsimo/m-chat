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
        if isRun == 0{
            print("isRun 0")
            present(taskViewContoller,animated: true,completion:nil)
            isRun = 1
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
                let id = parseID(id: String(describing: restorationStepID)).0
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
