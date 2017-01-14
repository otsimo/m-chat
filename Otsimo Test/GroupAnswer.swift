//
//  GroupAnswer.swift
//  OtsimoTest
//
//  Created by demirci on 14/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


class GroupAnswer {
    let id : String
    let groupName : String
    let answer : Bool
    init(id : String, answer : Bool, groupName : String) {
        self.id = id
        self.answer = answer
        if groupName==""||groupName=="*"{
            self.groupName = ""
        }else{
            self.groupName = groupName
        }
    }
}
