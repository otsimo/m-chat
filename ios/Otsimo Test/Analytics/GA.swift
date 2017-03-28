//
//  Google.swift
//  Family
//
//  Created by Sercan Değirmenci on 12/08/2016.
//  Copyright © 2016 Otsimo. All rights reserved.
//

import Foundation

class GoogleAnalytics: AnalyticsProtocol {
    var tracker: GAITracker!
    func start(_ env: String) {
        let gai = GAI.sharedInstance()
        gai?.trackUncaughtExceptions = true
        tracker = GAI.sharedInstance().tracker(withTrackingId: GAKey)
        gai?.defaultTracker = tracker
    }
    
    func setUserInfo() {
        tracker.set(kGAIAppName,value:"mchattest")
        let bundleShortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        tracker.set(kGAIAppVersion, value: bundleShortVersion)
    }
    
    func event(_ event: String, data: [String: Any]?) {
        if let payload = data {
            var builder:GAIDictionaryBuilder;
            if payload.count >= 2{
                let f = payload.first!
                let action="\(f.0):\(f.1)"
                let k = payload.keys[payload.index(payload.startIndex, offsetBy: 1)]
                let s = payload[k]
                let label="\(k):\(s)"
                builder = GAIDictionaryBuilder.createEvent(withCategory: event, action: action, label: label, value: nil)
            }else if payload.count==1{
                let f = payload.first!
                let action="\(f.0):\(f.1)"
                builder = GAIDictionaryBuilder.createEvent(withCategory: event, action: action, label: nil, value: nil)
            }else{
                builder = GAIDictionaryBuilder.createEvent(withCategory: event, action: "default", label: nil, value: nil)
            }
            let b: NSObject = builder.build()
            tracker.send(b as! [NSObject : AnyObject])
        } else {
            let builder = GAIDictionaryBuilder.createEvent(withCategory: event, action: "default", label: nil, value: nil)
            let b: NSObject = builder!.build()
            tracker.send(b as! [NSObject : AnyObject])
        }
    }
    
    func screen(_ name: String){
        tracker.set(kGAIScreenName, value: name)
    }
}
