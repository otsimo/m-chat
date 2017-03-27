//
//  ViewController+Popup.swift
//  OtsimoTest
//
//  Created by demirci on 27/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

extension ViewController{
    
    func showNotEligiblePopup(){
        let notEligibleVC = NotEligiblePopupController(nibName: "NotEligiblePopupController", bundle: nil)
        let popupVC = PopupDialog(viewController: notEligibleVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
        
        present(popupVC, animated: true, completion: nil)
    }
    
}
