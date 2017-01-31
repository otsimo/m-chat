//
//  ReadJSONs.swift
//  OtsimoTest
//
//  Created by demirci on 15/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation



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
    return (1...20).map(readStep)
}
