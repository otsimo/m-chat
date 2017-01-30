//
//  Otsimo.swift
//  Family
//
//  Created by Sercan Değirmenci on 20/04/16.
//  Copyright © 2016 Otsimo. All rights reserved.
//

import Foundation

class OtsimoAnalytics: AnalyticsProtocol {

    func start(_ env: String) {
    }

    func event(_ event: String, data: [String: Any]?) {
        if otsimosdk.analytics == nil {
            return;
        }
        if let payload = data {
            otsimosdk.analytics.appEvent(event: event, payload: payload as [String : AnyObject])
        } else {
            otsimosdk.analytics.appEvent(event: event, payload: [String: AnyObject]())
        }
    }
    
    func setUserInfo() {
    }
    
    func screen(_ name:String){
        
    }
}
