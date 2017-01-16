//
//  ResultModel.swift
//  OtsimoTest
//
//  Created by demirci on 16/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


class Result {
    var id : String
    var answer : NSNumber
    init(id : String , answer : NSNumber ) {
        self.id = id
        self.answer = answer
    }
}
