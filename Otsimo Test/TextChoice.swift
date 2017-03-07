//
//  TextChoice.swift
//  OtsimoTest
//
//  Created by demirci on 07/03/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//
import ResearchKit

public protocol TextChoice  {
    var choiceText: String { get }
    var choiceDetail: String? { get }
    var choiceValue: NSCoding & NSCopying & NSObjectProtocol { get }
    var exclusive: Bool { get }
}

extension TextChoice {
    func createORKTextChoice() -> ORKTextChoice {
        return ORKTextChoice(text: self.choiceText.trim() ?? "", detailText: self.choiceDetail?.trim(), value: self.choiceValue, exclusive: self.exclusive)
    }
}
extension String {
    public func trim() -> String? {
        let result = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard result != "" else { return nil }
        return result
    }
}
