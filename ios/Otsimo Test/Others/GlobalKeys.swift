//
//  Tasks.swift
//  OtsimoTest
//
//  Created by demirci on 30/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

enum Tasks {
    static let infoTaskID = "infoTaskID"
    static let consentTaskID = "consentTaskID"
    static let mChatRFTaskID = "mChatRFTaskID"
    static let mChatTaskID = "mChatTaskID"
}

enum CacheKeys {
    static let mChatRFKey = "restorationDataForMCHATRF"
    static let mChatRFLastQuestionIdKey = "lastQuestionIdOfMCHATRF"
    static let mChatKey = "restorationDataForMCHAT"
    static let userIDKey = "userID"
}
enum InfoStepIDs {
    static let relationStepID = "relation"
    static let genderStepID = "gender"
    static let birthDayStepID = "birthDay"
}

enum OtizmLevel {
    case none
    case low
    case medium
    case high
}
