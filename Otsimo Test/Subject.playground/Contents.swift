//: Playground - noun: a place where people can play

import UIKit
//enum Relation {
//    static let parent = "Parent"
//    static let grandParent = "GrandParent"
//    static let guardion = "Guardion"
//    static let educator = "Educator"
//    static let healtCareProvider = "Healt care provider"
//    static let other = "other"
//}
//
//enum Gender{
//    static let male = "Male"
//    static let female = "Female"
//}



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




let s = getSubject(relation: Relation.parent, gender: Gender.male)


