//
//  Flurry.swift
//  Family
//
//  Created by Sercan Değirmenci on 20/04/16.
//  Copyright © 2016 Otsimo. All rights reserved.
//

import Foundation

class FlurryAnalytics: AnalyticsProtocol {
    var isStarted:Bool = false
   
    func start(_ env: String) {
        if env=="production"{
            Flurry.startSession(flurryKey)
            isStarted = true
        }
    }

    func event(_ event: String, data: [String: Any]?) {
        if !isStarted {return}
        
        if let payload = data {
            Flurry.logEvent(event, withParameters: payload);
        } else {
            Flurry.logEvent(event)
        }
    }
    
    func setUserInfo() {
        if !isStarted{ return }
        Flurry.setUserID(app?.profileID)
    }
    
    func screen(_ name:String){
        if !isStarted{ return }
        Flurry.logEvent("screen", withParameters: ["name":name]);
    }
}
