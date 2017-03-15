//
//  LowResultPopupController.swift
//  OtsimoTest
//
//  Created by demirci on 27/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import UIKit

class LowResultPopupController: UIViewController {
    
    var point = 0
    @IBOutlet var lbl_result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_result.text = "M-CHAT Testinden Alınan Puan: " + String(point)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
