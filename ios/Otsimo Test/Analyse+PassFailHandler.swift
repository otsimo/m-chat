//
//  Analyse+PassFailHandler.swift
//  OtsimoTest
//
//  Created by demirci on 23/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

extension Analyse{
    
    func passFailHandlerForMCHAT(otsimoResults : Otsimo_Result) -> Int{
        print("results : ",otsimoResults)
        
        let results = otsimoResults.stepResults
        
        var qNum = 0
        var total = 0
        for stepResult in results{
            let result = stepResult.subStepResults[0].stepResults[0]
            qNum += 1
            if (qNum == 11 || qNum == 18 || qNum == 20 || qNum == 22){
                if (result.answer == "1"){
                    total += 1
                }
            }else {
                if (result.answer == "0"){
                    total += 1
                }
            }
        }
        return total
    }
}
