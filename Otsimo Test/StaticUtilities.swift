//
//  StaticUtilities.swift
//  OtsimoTest
//
//  Created by demirci on 24/02/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
public func SBAObjectEquality(_ objA: Any?, _ objB: Any?) -> Bool {
    if objA == nil && objB == nil {
        return true
    }
    guard let objA = objA as? NSObject, let objB = objB as? NSObject else {
        return false
    }
    return objA == objB
}

public func SBAObjectNonNilEquality(_ objA: Any?, _ objB: Any?) -> Bool {
    guard let objA = objA as? NSObject, let objB = objB as? NSObject else {
        return false
    }
    return objA == objB
}

public func SBAObjectHash(_ obj: Any?) -> Int {
    return (obj as? NSObject)?.hash ?? 0
}
