//
//  ConsentDocument.swift
//  Otsimo Test
//
//  Created by demirci on 29/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//

import ResearchKit

struct ConsentSectionType{
    var type: ORKConsentSectionType
    var id: String
    var isHtml:Bool
    var image:String
}

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = NSLocalizedString("Consent.title", comment: "")
    
    //consent sections
    let cst = [
        ConsentSectionType(type: .overview, id: "", isHtml: true,image:"" ),
        ConsentSectionType(type: .dataGathering, id: "", isHtml: true,image:""),
        ConsentSectionType(type: .privacy, id: "", isHtml: true,image:""),
        ConsentSectionType(type: .dataUse, id: "", isHtml: true,image:""),
        ConsentSectionType(type: .studySurvey, id: "", isHtml: true,image:""),
        ConsentSectionType(type: .custom, id: "a1", isHtml: true,image:"potential_benefits"),
        ConsentSectionType(type: .custom, id: "a2", isHtml: true,image:"potential_risk"),
        ConsentSectionType(type: .custom, id: "a3", isHtml: true,image:"not_medical"),
        ConsentSectionType(type: .custom, id: "a4", isHtml: true,image:"follow_up"),
    ]
    
    let consentSections: [ORKConsentSection] = cst.map { cs in
        let consentSection = ORKConsentSection(type: cs.type)
        var sum = ""
        var content = ""
        switch cs.type{
        case .overview:
             sum = NSLocalizedString("Consent.overview.sum", comment: "")
             content = NSLocalizedString("Consent.overview.html", comment: "")
            break
        case .dataGathering:
            sum = NSLocalizedString("Consent.dataGathering.sum", comment: "")
            content = NSLocalizedString("Consent.dataGathering.html", comment: "")
            break
        case .privacy:
            sum = NSLocalizedString("Consent.privacy.sum", comment: "")
            content = NSLocalizedString("Consent.privacy.html", comment: "")
            break
        case .dataUse:
            sum = NSLocalizedString("Consent.dataUse.sum", comment: "")
            content = NSLocalizedString("Consent.dataUse.html", comment: "")
            break
        case .studySurvey:
            sum = NSLocalizedString("Consent.studySurvey.sum", comment: "")
            content = NSLocalizedString("Consent.studySurvey.html", comment: "")
            break
        case .custom:
            sum = NSLocalizedString("\(cs.id).sum", comment: "")
            content = NSLocalizedString("\(cs.id).content", comment: "")
            consentSection.title=NSLocalizedString("\(cs.id).title", comment: "")
            break
        default:
            break
        }
        consentSection.summary = sum
        if(cs.isHtml){
            consentSection.htmlContent = content
        }else{
            consentSection.content = content
        }
        if(cs.image != ""){
            consentSection.customImage = UIImage(named: cs.image)
        }
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    
    //signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
