//
//  Server
//  OtsimoTest
//
//  Created by demirci on 18/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


class Server{
    
    
    func sendResult(json : String) -> String{
        
        var responseFromServer = "No Result"
        
        //https://mchatrest.otsimo.xyz
        var request = URLRequest(url: URL(string: "http://localhost:9002/addResult")!)
        request.httpMethod = "POST"
        request.httpBody = json.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            if let rspn = String(data: data, encoding: .utf8){
                responseFromServer = rspn
            }
            print("responseString = \(responseFromServer)")
        }
        task.resume()
        return responseFromServer
    }
    
    
}
