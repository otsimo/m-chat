//
//  ConsentDocument.swift
//  Otsimo Test
//
//  Created by demirci on 29/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = NSLocalizedString("consent.title", comment: "")
    
    //consent sections
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .studySurvey,
    ]
    
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        var sum = ""
        var content = ""
        switch contentSectionType{
        case .overview:
             sum = NSLocalizedString("Consent.overview.sum", comment: "")
             content = NSLocalizedString("Consent.overview.content", comment: "")
            break
        case .dataGathering:
            sum = NSLocalizedString("Consent.dataGathering.sum", comment: "")
            content = NSLocalizedString("Consent.dataGathering.content", comment: "")
            break
        case .privacy:
            sum = NSLocalizedString("Consent.privacy.sum", comment: "")
            content = NSLocalizedString("Consent.privacy.content", comment: "")
            break
        case .dataUse:
            sum = NSLocalizedString("Consent.dataUse.sum", comment: "")
            content = NSLocalizedString("Consent.dataUse.content", comment: "")
            break
        case .studySurvey:
            sum = NSLocalizedString("Consent.studySurvey.sum", comment: "")
            content = NSLocalizedString("Consent.studySurvey.content", comment: "")
            break
        default:
            break
        }
        consentSection.summary = sum
        consentSection.content = content
        return consentSection
    }
    consentDocument.sections = consentSections
    
    
    //signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
