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
        
        if let wifiAdress = getWiFiAddress(){
            ip = wifiAdress
        }
        
        
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
    
    // Return IP address of WiFi interface (en0) as a String, or `nil`
    func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var addr = interface.ifa_addr.pointee
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    
}
