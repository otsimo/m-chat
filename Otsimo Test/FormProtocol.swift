//
//  FormProtocol.swift
//  OtsimoTest
//
//  Created by demirci on 07/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import ResearchKit

/**
 A class that conforms to the properties of the `ORKFormStep` but does not require
 inheritance from `ORKFormStep`
 */
@objc
public protocol FormStepProtocol : class {
    var identifier: String { get }
    var title: String? { get set }
    var text: String? { get set }
    var formItems: [ORKFormItem]? { get set }
    init(identifier: String)
}

extension FormStepProtocol {
    
    /**
     Convenience method for finding a form item with the given identifier.
     
     @param     identifier  The identifier string for the `ORKFormItem`
     @return                The form item (if found)
     */
    public func formItem(for identifier: String) -> ORKFormItem? {
        return self.formItems?.find({ $0.identifier == identifier })
    }
}

extension ORKFormStep: FormStepProtocol {
}

extension ORKQuestionStep: FormStepProtocol {
    
    public var formItems: [ORKFormItem]? {
        get {
            return [ORKFormItem(identifier: self.identifier, text: nil, answerFormat: self.answerFormat)]
        }
        set {
            self.answerFormat = newValue?.find(withIdentifier: self.identifier)?.answerFormat
        }
    }
}
