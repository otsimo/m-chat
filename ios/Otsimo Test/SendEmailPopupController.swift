//
//  SendEmailPopupController.swift
//  OtsimoTest
//
//  Created by demirci on 20/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import UIKit

class SendEmailPopupController: UIViewController {

    @IBOutlet var txt_email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendEmailTapped(_ sender: UIButton) {
        let server = Server()
        var userInfo = Otsimo_UserInfo()
        if let userID = UserDefaults.standard.string(forKey: CacheKeys.userIDKey){
            userInfo.userId = userID
        }

        if let email = txt_email.text {
            do {
                userInfo.email = email
                let json = try userInfo.serializeJSON()
                server.sendUserInfo(json: json)
            } catch let err {
                print("error : ", err)
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
