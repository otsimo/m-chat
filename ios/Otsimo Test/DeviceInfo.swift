//
//  DeviceInfo.swift
//  OtsimoTest
//
//  Created by demirci on 17/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import UIKit

extension Otsimo_DeviceInfo {
    static func platform() -> String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    init(os: String) {
        self.init()
        let device = UIDevice.current
        let locale = Locale.current
        let bundle = Bundle.main
        
        
        if let iDictionary = bundle.infoDictionary{
            let infoDictionary = iDictionary
            bundleIdentifier = infoDictionary["CFBundleIdentifier"] as! String
            bundleVersion = infoDictionary["CFBundleVersion"] as! String
            bundleShortVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

        }
        if let ifv = device.identifierForVendor {
            vendorId = ifv.uuidString
        } else {
            vendorId = ""
        }
        osName = os
        languageCode = (locale as NSLocale).object(forKey: NSLocale.Key.languageCode) as! String
        if let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) {
            countryCode = code as! String
        }
        systemVersion = device.systemVersion
        deviceType = device.model.replacingOccurrences(of: " ", with: "")
        deviceName = Otsimo_DeviceInfo.platform()

    }
    
    
    
}
