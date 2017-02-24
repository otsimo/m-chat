//
//  AnswerFormatFinder.swift
//  OtsimoTest
//
//  Created by demirci on 24/02/2017.
//  Copyright © 2017 . All rights reserved.
//

import Foundation
import ResearchKit


public protocol AnswerFormatFinder: class {
    
    /**
     Find the `ORKAnswerFormat` that maps to a given identifier string. Returns `nil` if not found.
     @param identifier   Identifier for the form item.
     @return             Answer format for the form item (if found)
     */
    func find(for identifier:String) -> ORKAnswerFormat?
    
    /**
     Find the `ResultIdentifier` that maps to the given identifier string. Returns `nil` if not found.
     @param identifier   Identifier for the form item.
     @return             result identifier (step and subresult) if found.
     */
    func resultIdentifier(for identifier:String) -> ResultIdentifier?
}

public final class ResultIdentifier: NSObject {
    public let identifier: String
    public let stepIdentifier: String
    
    public init(identifier: String, stepIdentifier: String) {
        self.identifier = identifier
        self.stepIdentifier = stepIdentifier
        super.init()
    }
}

extension ORKQuestionStep: AnswerFormatFinder {
    
    public func find(for identifier:String) -> ORKAnswerFormat? {
        guard identifier == self.identifier else { return nil }
        return self.answerFormat
    }
    
    public func resultIdentifier(for identifier: String) -> ResultIdentifier? {
        guard identifier == self.identifier else { return nil }
        return ResultIdentifier(identifier: identifier, stepIdentifier: self.identifier)
    }
}

extension ORKFormStep: AnswerFormatFinder {
    
    public func find(for identifier:String) -> ORKAnswerFormat? {
        guard let formItems = self.formItems else { return nil }
        for formItem in formItems {
            if formItem.identifier == identifier {
                return formItem.answerFormat
            }
        }
        return nil
    }
    
    public func resultIdentifier(for identifier: String) -> ResultIdentifier? {
        guard find(for: identifier) != nil else { return nil }
        return ResultIdentifier(identifier: identifier, stepIdentifier: self.identifier)
    }
}
