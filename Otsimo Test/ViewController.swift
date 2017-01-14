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


func readStep(i : Int)-> Otsimo_Mchat_Step{
    
    let url = Bundle.main.url(forResource: "questions/q\(i)", withExtension: "json")
    do {
        let data = try Data(contentsOf: url!)
        let json = String(data: data, encoding: .utf8)
        let step = try Otsimo_Mchat_Step(json: json! )
        return step
    } catch let e{
        print("error 1 ->",e)
    }
    return Otsimo_Mchat_Step()
}


func readSteps()->[Otsimo_Mchat_Step]{
    return (1...5).map(readStep)
}


class ViewController: UIViewController {

    
    override func viewDidAppear(_ animated: Bool) {
        present(self.taskViewContoller, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {


    }
    
    
    lazy var taskViewContoller:ORKTaskViewController = {
        let steps = readSteps()
        let taskViewController = ORKTaskViewController(task: SurveyTask(Pollster(steps:steps, firstStep:"1")), taskRun: nil)
        taskViewController.delegate = self
        return taskViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
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
