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

    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    let htmlContents = ["1", "2"]

    @IBOutlet weak var collectionView: UICollectionView!
    var isRun = 10
    var taskResult: ORKTaskResult?
    var iResult = Otsimo_Info()
    let anlyse = Analyse()
    var resultJSON = ""
    let defaultSurvey = Tasks.mChatTaskID
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 1
    }

    @IBOutlet weak var surveyButton: UIButton!
    @IBAction func StartSurvey(_ sender: UIButton) {
        
        switch defaultSurvey {
        case Tasks.mChatTaskID:
            present(mChatVC, animated: true, completion: nil)
        case Tasks.mChatRFTaskID:
            present(mChatRFVC, animated: true, completion: nil)
        default:
            Log.debug("There is not any default tasks")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.debug("ViewController : viewDidLoad")

        
        let nib = UINib(nibName: "WalkThroughCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "walkThroughCell")
        collectionView.delegate = self
        collectionView.contentSize.height = collectionView.frame.size.height
        collectionView.contentSize.width = collectionView.frame.size.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("viewWillDisappear")
        
        
        switch defaultSurvey {
        case Tasks.mChatTaskID:
            //RestoretionFor mChat 
            break;
        case Tasks.mChatRFTaskID:
            let savedData = mChatRFVC.restorationData
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(savedData, forKey: CacheKeys.mChatRFKey)
        default:
            Log.debug("There is not any default tasks")
        }
        

        
    }
    
    
    
    var pollster = Pollster(firstStep: "1")
    
    lazy var mChatVC: ORKTaskViewController = {
       
        
        var newSteps = InfoTask.steps + ConsentTask.steps + MChatTask.steps
        var newTask = ORKOrderedTask(identifier: Tasks.mChatTaskID, steps: newSteps)
        if let restorationData = UserDefaults.standard.data(forKey: CacheKeys.mChatKey) {
            print("restorationData")
            let mChatVC = ORKTaskViewController(task: newTask, restorationData: restorationData, delegate: self)
            return mChatVC
        }
        let mChatVC = ORKTaskViewController(task: newTask, taskRun: nil)
        mChatVC.delegate = self
        return mChatVC
    }()
    
    
    lazy var mChatRFVC: ORKTaskViewController = {
        if let restorationData = UserDefaults.standard.data(forKey: CacheKeys.mChatRFKey) {
            print("restorationData")
            if let restorationStepID = UserDefaults.standard.string(forKey: CacheKeys.mChatRFLastQuestionIdKey) {
                print("restorationStepID ->", restorationStepID)
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


}
