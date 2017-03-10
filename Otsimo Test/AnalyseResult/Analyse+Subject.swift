//
//  Analyse+Subject.swift
//  OtsimoTest
//
//  Created by demirci on 19/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


extension Analyse{
    
    enum Relation {
        case parent
        case grandParent
        case guardion
        case educator
        case healtCareProvider
        case other
    }
    enum Gender {
        case male
        case female
        case other
    }
    enum Sub {
        case yourChild
        case yourSon
        case yourDaughter
        case yourGrandSon
        case yourGrandDaughter
        case yourStudent
        case theChild
    }
    
    func getRelation(info : Otsimo_Info) -> String{
        return info.relation
    }
    func getGender(info : Otsimo_Info) -> String{
        return info.gender
    }
    
    func getSubject(relation: Relation?, gender: Gender?) -> Sub {
        
        if let r = relation {
            switch r {
            case .parent:
                
                if let g = gender {
                    switch g {
                    case .male:
                        return .yourSon
                    case .female:
                        return .yourDaughter
                    default:
                        return .yourChild
                    }
                }
                return .yourChild
            case .grandParent:
                if let g = gender {
                    switch g {
                    case .male:
                        return .yourGrandSon
                    case .female:
                        return .yourGrandDaughter
                    default:
                        return .yourChild
                    }
                }
            case .guardion:
                return .theChild
            case .educator:
                return .yourStudent
            case .healtCareProvider:
                return .theChild
            case .other:
                return .theChild
            }
        }
        return .theChild
    }

}
