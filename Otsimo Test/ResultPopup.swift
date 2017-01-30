//
//  ResultPopup.swift
//  OtsimoTest
//
//  Created by demirci on 30/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import PopupDialog

extension ViewController {
    func showResultScene(passNum: Int, failNum: Int) {


        // Create second button
        let buttonSave = DefaultButton(title: "Save") {
            print("You ok'd the default dialog")
            self.showSavePopup()
        }
        buttonSave.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
        buttonSave.titleColor = UIColor.white

        let buttonShare = DefaultButton(title: "Share") {
            print("share")
            let shareController = UIActivityViewController(activityItems: ["aa"], applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)
        }

        buttonShare.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
        buttonShare.titleColor = UIColor.white




        if (failNum >= 0 && failNum <= 2) {
            print("LOW RİSK")

            let resultVC = HighResultPopupController(nibName: "LowResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)


            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)

        } else if (failNum >= 3 && failNum <= 7) {
            print("MEDIUM RİSK")
            let resultVC = HighResultPopupController(nibName: "MediumResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        } else if (failNum >= 8 && failNum <= 20) {
            print("HIGH RİSK")
            let resultVC = HighResultPopupController(nibName: "HighResultPopup", bundle: nil)
            resultVC.point = passNum
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        }


    }
    
    func showSavePopup(){
        
        
        let saveVC = HighResultPopupController(nibName: "SendEmailPopup", bundle: nil)
        
        let popupVC = PopupDialog(viewController: saveVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
        
        let buttonSave = DefaultButton(title: "Save") { 
            print("Save")
        }
        
        popupVC.addButton(buttonSave)
        present(popupVC, animated: true, completion: nil)
    }

}
