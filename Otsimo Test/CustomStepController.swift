//
//  CustomStepController.swift
//  OtsimoTest
//
//  Created by demirci on 06/02/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import UIKit
import ResearchKit

class CustomStepController: ORKQuestionStepViewController {

    override init(step: ORKStep?) {
        super.init(step: step)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // IntroStepView.xib will used
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        stepDidChange()
    }

    func stepDidChange() {

        guard step != nil && isViewLoaded else {
            return
        }

        // Additional setup

    }
}

