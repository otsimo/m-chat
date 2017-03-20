//
//  ResultPopup.swift
//  OtsimoTest
//
//  Created by demirci on 30/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

extension ViewController {
    func showResultScene(passNum: Int, failNum: Int) {


        // Create second button
        let buttonSave = DefaultButton(title: "Save") {
            print("You ok'd the default dialog")
        }
        buttonSave.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
        buttonSave.titleColor = UIColor.white

        let buttonShare = DefaultButton(title: "Share") {
            print("share")
            self.showShareView()
        }

        buttonShare.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
        buttonShare.titleColor = UIColor.white

        if (failNum >= 0 && failNum <= 2) {
            print("LOW RİSK")

            let resultVC = HighResultPopupController(nibName: "LowResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)


            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)

        } else if (failNum >= 3 && failNum <= 7) {
            print("MEDIUM RİSK")
            let resultVC = HighResultPopupController(nibName: "MediumResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        } else if (failNum >= 8 && failNum <= 20) {
            print("HIGH RİSK")
            let resultVC = HighResultPopupController(nibName: "HighResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        }


    }
    
    func showSavePopup(){
        print("showSavePopup")
        
        
        let saveVC = SendEmailPopupController(nibName: "SendEmailPopupController", bundle: nil)
        
        let popupVC = PopupDialog(viewController: saveVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
        
        present(popupVC, animated: true, completion: nil)
 
    }
    
    func showShareView(){
        // text to share
        print("resulttttt->",resultJSON)
        let text = resultJSON
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.message ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

}
