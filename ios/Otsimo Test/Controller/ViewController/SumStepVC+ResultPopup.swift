//
//  ResultPopup.swift
//  OtsimoTest
//
//  Created by demirci on 30/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

extension SumStepVC {
    func showResultScene(total: Int) {


        // Create second button
        let buttonSave = DefaultButton(title: "Save") {
            analytics.event("press-Save-Button-ResultPopup", data: [:])
            self.dismiss(animated: true, completion: nil)
            self.showSavePopup()
        }
        buttonSave.titleColor = UIColor.white

        let buttonShare = DefaultButton(title: "Share") {
            analytics.event("press-Share-Button-ResultPopup", data: [:])
            print("share")
            self.showShareView(total)
        }

        buttonShare.titleColor = UIColor.white

        if (total >= 0 && total <= 2) {

            self.level = OtizmLevel.low

            buttonSave.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)
            buttonShare.backgroundColor = UIColor(red: 0.30, green: 0.65, blue: 0.24, alpha: 1.0)

            let resultVC = LowResultPopupController(nibName: "LowResultPopup", bundle: nil)
            resultVC.point = total
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)


            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)

        } else if (total >= 3 && total <= 6) {

            self.level = OtizmLevel.medium


            buttonSave.backgroundColor = UIColor(red: 0.88, green: 0.40, blue: 0.10, alpha: 1.0)
            buttonShare.backgroundColor = UIColor(red: 0.88, green: 0.40, blue: 0.10, alpha: 1.0)

            let resultVC = MediumResultPopupController(nibName: "MediumResultPopup", bundle: nil)
            resultVC.point = total
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        } else if (total >= 7 && total <= 20) {

            self.level = OtizmLevel.high


            buttonSave.backgroundColor = UIColor(red: 0.85, green: 0.09, blue: 0.15, alpha: 1.0)
            buttonShare.backgroundColor = UIColor(red: 0.85, green: 0.09, blue: 0.15, alpha: 1.0)

            let resultVC = HighResultPopupController(nibName: "HighResultPopup", bundle: nil)
            resultVC.point = total
            let popupVC = PopupDialog(viewController: resultVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

            // Add buttons to dialog
            popupVC.addButtons([buttonSave, buttonShare])
            present(popupVC, animated: true, completion: nil)
        }


    }

    func showSavePopup() {

        let saveVC = SendEmailPopupController(nibName: "SendEmailPopupController", bundle: nil)

        let popupVC = PopupDialog(viewController: saveVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)

        present(popupVC, animated: true, completion: nil)

    }

    func showShareView(_ point: Int) {
        // set up activity view controller





        let textToShare = [ getShareText(point)]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.message]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

    func getShareText(_ point: Int) -> String {

        var text = ""
        switch level {
        case .low:
            text += NSLocalizedString("lowLevel", comment: "")
        case .medium:
            text += NSLocalizedString("mediumLevel", comment: "")
        case .high:
            text += NSLocalizedString("highLevel", comment: "")
        default:
            break
        }
        text += NSLocalizedString("alinanPuan", comment: "")
        text += " " + String(point)
        text += NSLocalizedString("withapp", comment: "")
        print("sharing Text : ",text)
        return text
    }

}
