//
//  Aws.swift
//  Family
//
//  Created by Sercan Değirmenci on 14/10/2016.
//  Copyright © 2016 Otsimo. All rights reserved.
//

import Foundation
import AWSMobileAnalytics

class AwsAnalytics: AnalyticsProtocol {
    var isStarted:Bool = false
    var analytics:AWSMobileAnalytics?
    
    func start(_ env: String) {
        if env == "production"{
            analytics = AWSMobileAnalytics(forAppId: AWSAppID,
                                       identityPoolId: AWSIdentityPoolId)
            isStarted = true
        }
    }
    
    func event(_ event: String, data: [String: Any]?) {
        if !isStarted {return}
        guard let client = self.analytics?.eventClient else{
            return
        }
        let ev = client.createEvent(withEventType: event)
        if let payload = data {
            for (k,v) in payload{
                ev?.addAttribute("\(v)", forKey: k)
            }
        }
        client.record(ev)
    }
    
    func setUserInfo() {
    }
    
    func screen(_ name:String){
        guard let client = self.analytics?.eventClient else{
            return
        }
        let ev = client.createEvent(withEventType: "screen")
        ev?.addAttribute(name, forKey: "name")
        client.record(ev)
    }
}
