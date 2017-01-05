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

    override func viewDidAppear(_ animated: Bool) {
//        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
//        taskViewController.delegate = self
//        present(taskViewController, animated: true, completion: nil)

//        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
//        taskViewController.delegate = self
//        present(taskViewController, animated: true, completion: nil)


        // let taskViewController = ORKTaskViewController(task: SurveyTask2(), taskRun: nil)
        //taskViewController.delegate = self
        //   present(taskViewController, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


//        if let path = Bundle.main.path(forResource: "q1", ofType: "json")
//        {
//             let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
//                if let jsonResult: NSDictionary = JSONSerialization.JSONObjectWithData(jsonData, options: JSONSerialization.ReadingOptions.MutableContainers, error: nil) as? NSDictionary
//                {
//                   print(jsonResult)
//                }
//        }
//
//
//
  



        let url = Bundle.main.url(forResource: "questions/q1", withExtension: "json")

        do {
            let data = try Data(contentsOf: url!)
            let json = String(data: data, encoding: .utf8)
            let step = try Otsimo_Mchat_Step(json: json! )
            print("id", step.id)
            
            for s in step.questions{
                print(s)
            }
            
            
            
        } catch let e{
            print("error 1 ->",e)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: ORKTaskViewControllerDelegate {

    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
    }

}
