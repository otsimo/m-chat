//
//  ConsentTask.swift
//  Otsimo Test
//
//  Created by demirci on 29/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//

import ResearchKit

public var ConsentTask: ORKOrderedTask {

    
    ///
    var steps = [ORKStep]()
    //VisualConsentStep

    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    //Add ConsentReviewStep

    //let signature = consentDocument.signatures!.first as! ORKConsentSignature
    
    //let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
//    reviewConsentStep.text = "Review Consent!"
//    reviewConsentStep.reasonForConsent = "Consent to join study"
//    
//    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
