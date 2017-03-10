//
//  HighResultPopupController.swift
//  OtsimoTest
//
//  Created by demirci on 27/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import UIKit

class HighResultPopupController: UIViewController {
    
    var point = 0
    
    
    @IBOutlet weak var lbl_result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_result.text = "M-CHAT Testinden Alınan Puan: " + String(point)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
