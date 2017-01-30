//
//  MixPanel.swift
//  Family
//
//  Created by Sercan Değirmenci on 14/10/2016.
//  Copyright © 2016 Otsimo. All rights reserved.
//

import Foundation
import Mixpanel

class MixPanelAnalytics: AnalyticsProtocol {
    var isStarted:Bool = false
    
    func start(_ env: String) {
        if env=="production"{
            Mixpanel.initialize(token: MixpanelToken)
            isStarted = true
        }
    }
    
    func event(_ event: String, data: [String: Any]?) {
        if !isStarted {return}
        
        if let payload = data {
            Mixpanel.mainInstance().track(event: event,
                                          properties: properties(data: payload))
        } else {
             Mixpanel.mainInstance().track(event: event)
        }
    }
    
    func setUserInfo() {
        if !isStarted{ return }
        if let pid = app?.profileID{
            Mixpanel.mainInstance().identify(distinctId: pid)
        }
        app?.profile({ (pro) in
            guard let p = pro else{
                return
            }
            Mixpanel.mainInstance().people.set(property: "email", to: p.email)
            Mixpanel.mainInstance().people.set(property: "country", to: p.country)
        })
    }
    
    func screen(_ name:String){
        if !isStarted{ return }
        Mixpanel.mainInstance().track(event: "screen",properties: ["name":name])
    }
    
    func properties(data: [String: Any])->Properties{
        var prop = Properties()
        for (k,v) in data{
            if v is String{
                prop[k] = v as! String
            }else if v is Int{
                prop[k] = v as! Int
            }else if v is Float{
                prop[k] = v as! Float
            }else if v is Double{
                prop[k] = v as! Double
            }else if v is Bool{
                prop[k] = v as! Bool
            }
        }
        return prop
    }
}
