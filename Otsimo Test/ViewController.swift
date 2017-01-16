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




class ViewController: UIViewController {

    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?

    var isRun = 0
    var taskResult: ORKTaskResult?
    override func viewDidAppear(_ animated: Bool) {
        Log.debug("ViewController : viewDidAppear")
        
        if isRun == 0 {
            Log.debug("isRun 0")
             present(consentTaskVC, animated: true, completion: nil)
            isRun = 1
        }else if isRun == 1{
            Log.debug("isRun 1")
           present(infoTaskVC, animated: true, completion: nil)
            isRun = 2
        }else if isRun == 2{
            Log.debug("isRun 2")
            present(taskViewContoller, animated: true, completion: nil)
            isRun = 3
        }
        

//        if let tr = taskResult {
//            print("taskResult ---->", tr)
//            AnalyseResult(taskResult: tr)
//        }


       


    }



    func AnalyseResult(taskResult: ORKTaskResult) {
        var EndResult: [Result] = []
        if let taskResults = taskResult.results {
            print("1")
            for results in taskResults {
                print("2")

                let sresults = results as! ORKStepResult
                print("3")

                if let stepResult = sresults.results {
                    print("4")

                    for sr in stepResult {
                        print("5")

                        let br = sr as! ORKBooleanQuestionResult
                        print(br)
                        if let a = br.booleanAnswer {
                            let r = Result(id: br.identifier, answer: a)
                            EndResult.append(r)

                        }
                    }
                }
            }
        }
        for r in EndResult {
            print(r.id, r.answer)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        Log.debug("ViewController : viewWillAppear")

    }
    var pollster = Pollster(firstStep: "1")





    lazy var taskViewContoller: ORKTaskViewController = {
        var pollster = Pollster(firstStep: "1")
        let taskViewController = ORKTaskViewController(task: SurveyTask(pollster), taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as! String, isDirectory: true) as URL
        return taskViewController
    }()

    lazy var consentTaskVC : ORKTaskViewController = {
        let consentTaskVC = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        consentTaskVC.delegate = self
        return consentTaskVC
    }()
    
    lazy var infoTaskVC : ORKTaskViewController = {
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
