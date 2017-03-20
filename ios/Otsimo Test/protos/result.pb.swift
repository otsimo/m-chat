/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: result.proto
 *
 */

import Foundation
import SwiftProtobuf


public enum Otsimo_SurveyType: ProtobufEnum {
  public typealias RawValue = Int
  case mchat // = 0
  case mchatrf // = 1
  case UNRECOGNIZED(Int)

  public init() {
    self = .mchat
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .mchat
    case 1: self = .mchatrf
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public init?(name: String) {
    switch name {
    case "mchat": self = .mchat
    case "mchatrf": self = .mchatrf
    default: return nil
    }
  }

  public init?(jsonName: String) {
    switch jsonName {
    case "MCHAT": self = .mchat
    case "MCHATRF": self = .mchatrf
    default: return nil
    }
  }

  public init?(protoName: String) {
    switch protoName {
    case "MCHAT": self = .mchat
    case "MCHATRF": self = .mchatrf
    default: return nil
    }
  }

  public var rawValue: Int {
    get {
      switch self {
      case .mchat: return 0
      case .mchatrf: return 1
      case .UNRECOGNIZED(let i): return i
      }
    }
  }

  public var json: String {
    get {
      switch self {
      case .mchat: return "\"MCHAT\""
      case .mchatrf: return "\"MCHATRF\""
      case .UNRECOGNIZED(let i): return String(i)
      }
    }
  }

  public var hashValue: Int { return rawValue }

  public var debugDescription: String {
    get {
      switch self {
      case .mchat: return ".mchat"
      case .mchatrf: return ".mchatrf"
      case .UNRECOGNIZED(let v): return ".UNRECOGNIZED(\(v))"
      }
    }
  }

}

public struct Otsimo_QuestionResult: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_QuestionResult"}
  public var protoMessageName: String {return "QuestionResult"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "id": 1,
    "answer": 2,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "id": 1,
    "answer": 2,
  ]}

  public var id: String = ""

  public var answer: String = ""

  public init() {}

  public init(id: String? = nil,
    answer: String? = nil)
  {
    if let v = id {
      self.id = v
    }
    if let v = answer {
      self.answer = v
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    let handled: Bool
    switch protoFieldNumber {
    case 1: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &id)
    case 2: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &answer)
    default:
      handled = false
    }
    return handled
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    if id != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: id, protoFieldNumber: 1, protoFieldName: "id", jsonFieldName: "id", swiftFieldName: "id")
    }
    if answer != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: answer, protoFieldNumber: 2, protoFieldName: "answer", jsonFieldName: "answer", swiftFieldName: "answer")
    }
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_QuestionResult) -> Bool {
    if id != other.id {return false}
    if answer != other.answer {return false}
    return true
  }
}

public struct Otsimo_SubStepResult: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_SubStepResult"}
  public var protoMessageName: String {return "SubStepResult"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "id": 1,
    "startDate": 2,
    "endDate": 3,
    "stepResults": 4,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "id": 1,
    "startDate": 2,
    "endDate": 3,
    "stepResults": 4,
  ]}

  public var id: String = ""

  public var startDate: Int64 = 0

  public var endDate: Int64 = 0

  public var stepResults: [Otsimo_QuestionResult] = []

  public init() {}

  public init(id: String? = nil,
    startDate: Int64? = nil,
    endDate: Int64? = nil,
    stepResults: [Otsimo_QuestionResult] = [])
  {
    if let v = id {
      self.id = v
    }
    if let v = startDate {
      self.startDate = v
    }
    if let v = endDate {
      self.endDate = v
    }
    if !stepResults.isEmpty {
      self.stepResults = stepResults
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    let handled: Bool
    switch protoFieldNumber {
    case 1: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &id)
    case 2: handled = try setter.decodeSingularField(fieldType: ProtobufInt64.self, value: &startDate)
    case 3: handled = try setter.decodeSingularField(fieldType: ProtobufInt64.self, value: &endDate)
    case 4: handled = try setter.decodeRepeatedMessageField(fieldType: Otsimo_QuestionResult.self, value: &stepResults)
    default:
      handled = false
    }
    return handled
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    if id != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: id, protoFieldNumber: 1, protoFieldName: "id", jsonFieldName: "id", swiftFieldName: "id")
    }
    if startDate != 0 {
      try visitor.visitSingularField(fieldType: ProtobufInt64.self, value: startDate, protoFieldNumber: 2, protoFieldName: "startDate", jsonFieldName: "startDate", swiftFieldName: "startDate")
    }
    if endDate != 0 {
      try visitor.visitSingularField(fieldType: ProtobufInt64.self, value: endDate, protoFieldNumber: 3, protoFieldName: "endDate", jsonFieldName: "endDate", swiftFieldName: "endDate")
    }
    if !stepResults.isEmpty {
      try visitor.visitRepeatedMessageField(value: stepResults, protoFieldNumber: 4, protoFieldName: "stepResults", jsonFieldName: "stepResults", swiftFieldName: "stepResults")
    }
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_SubStepResult) -> Bool {
    if id != other.id {return false}
    if startDate != other.startDate {return false}
    if endDate != other.endDate {return false}
    if stepResults != other.stepResults {return false}
    return true
  }
}

public struct Otsimo_StepResult: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_StepResult"}
  public var protoMessageName: String {return "StepResult"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "id": 1,
    "subStepResults": 2,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "id": 1,
    "subStepResults": 2,
  ]}

  public var id: String = ""

  public var subStepResults: [Otsimo_SubStepResult] = []

  public init() {}

  public init(id: String? = nil,
    subStepResults: [Otsimo_SubStepResult] = [])
  {
    if let v = id {
      self.id = v
    }
    if !subStepResults.isEmpty {
      self.subStepResults = subStepResults
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    let handled: Bool
    switch protoFieldNumber {
    case 1: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &id)
    case 2: handled = try setter.decodeRepeatedMessageField(fieldType: Otsimo_SubStepResult.self, value: &subStepResults)
    default:
      handled = false
    }
    return handled
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    if id != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: id, protoFieldNumber: 1, protoFieldName: "id", jsonFieldName: "id", swiftFieldName: "id")
    }
    if !subStepResults.isEmpty {
      try visitor.visitRepeatedMessageField(value: subStepResults, protoFieldNumber: 2, protoFieldName: "subStepResults", jsonFieldName: "subStepResults", swiftFieldName: "subStepResults")
    }
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_StepResult) -> Bool {
    if id != other.id {return false}
    if subStepResults != other.subStepResults {return false}
    return true
  }
}

public struct Otsimo_Result: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_Result"}
  public var protoMessageName: String {return "Result"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "info": 1,
    "device": 2,
    "duration": 3,
    "stepResults": 4,
    "version": 5,
    "surveyType": 6,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "info": 1,
    "device": 2,
    "duration": 3,
    "stepResults": 4,
    "version": 5,
    "surveyType": 6,
  ]}

  private class _StorageClass {
    typealias ProtobufExtendedMessage = Otsimo_Result
    var _info: Otsimo_Info? = nil
    var _device: Otsimo_DeviceInfo? = nil
    var _duration: Int64 = 0
    var _stepResults: [Otsimo_StepResult] = []
    var _version: Int32 = 0
    var _surveyType: Otsimo_SurveyType = Otsimo_SurveyType.mchat

    init() {}

    func decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
      let handled: Bool
      switch protoFieldNumber {
      case 1: handled = try setter.decodeSingularMessageField(fieldType: Otsimo_Info.self, value: &_info)
      case 2: handled = try setter.decodeSingularMessageField(fieldType: Otsimo_DeviceInfo.self, value: &_device)
      case 3: handled = try setter.decodeSingularField(fieldType: ProtobufInt64.self, value: &_duration)
      case 4: handled = try setter.decodeRepeatedMessageField(fieldType: Otsimo_StepResult.self, value: &_stepResults)
      case 5: handled = try setter.decodeSingularField(fieldType: ProtobufInt32.self, value: &_version)
      case 6: handled = try setter.decodeSingularField(fieldType: Otsimo_SurveyType.self, value: &_surveyType)
      default:
        handled = false
      }
      return handled
    }

    func traverse(visitor: inout ProtobufVisitor) throws {
      if let v = _info {
        try visitor.visitSingularMessageField(value: v, protoFieldNumber: 1, protoFieldName: "info", jsonFieldName: "info", swiftFieldName: "info")
      }
      if let v = _device {
        try visitor.visitSingularMessageField(value: v, protoFieldNumber: 2, protoFieldName: "device", jsonFieldName: "device", swiftFieldName: "device")
      }
      if _duration != 0 {
        try visitor.visitSingularField(fieldType: ProtobufInt64.self, value: _duration, protoFieldNumber: 3, protoFieldName: "duration", jsonFieldName: "duration", swiftFieldName: "duration")
      }
      if !_stepResults.isEmpty {
        try visitor.visitRepeatedMessageField(value: _stepResults, protoFieldNumber: 4, protoFieldName: "stepResults", jsonFieldName: "stepResults", swiftFieldName: "stepResults")
      }
      if _version != 0 {
        try visitor.visitSingularField(fieldType: ProtobufInt32.self, value: _version, protoFieldNumber: 5, protoFieldName: "version", jsonFieldName: "version", swiftFieldName: "version")
      }
      if _surveyType != Otsimo_SurveyType.mchat {
        try visitor.visitSingularField(fieldType: Otsimo_SurveyType.self, value: _surveyType, protoFieldNumber: 6, protoFieldName: "surveyType", jsonFieldName: "surveyType", swiftFieldName: "surveyType")
      }
    }

    func isEqualTo(other: _StorageClass) -> Bool {
      if _info != other._info {return false}
      if _device != other._device {return false}
      if _duration != other._duration {return false}
      if _stepResults != other._stepResults {return false}
      if _version != other._version {return false}
      if _surveyType != other._surveyType {return false}
      return true
    }

    func copy() -> _StorageClass {
      let clone = _StorageClass()
      clone._info = _info
      clone._device = _device
      clone._duration = _duration
      clone._stepResults = _stepResults
      clone._version = _version
      clone._surveyType = _surveyType
      return clone
    }
  }

  private var _storage = _StorageClass()

  public var info: Otsimo_Info {
    get {return _storage._info ?? Otsimo_Info()}
    set {_uniqueStorage()._info = newValue}
  }

  public var device: Otsimo_DeviceInfo {
    get {return _storage._device ?? Otsimo_DeviceInfo()}
    set {_uniqueStorage()._device = newValue}
  }

  public var duration: Int64 {
    get {return _storage._duration}
    set {_uniqueStorage()._duration = newValue}
  }

  public var stepResults: [Otsimo_StepResult] {
    get {return _storage._stepResults}
    set {_uniqueStorage()._stepResults = newValue}
  }

  public var version: Int32 {
    get {return _storage._version}
    set {_uniqueStorage()._version = newValue}
  }

  public var surveyType: Otsimo_SurveyType {
    get {return _storage._surveyType}
    set {_uniqueStorage()._surveyType = newValue}
  }

  public init() {}

  public init(info: Otsimo_Info? = nil,
    device: Otsimo_DeviceInfo? = nil,
    duration: Int64? = nil,
    stepResults: [Otsimo_StepResult] = [],
    version: Int32? = nil,
    surveyType: Otsimo_SurveyType? = nil)
  {
    let storage = _uniqueStorage()
    storage._info = info
    storage._device = device
    if let v = duration {
      storage._duration = v
    }
    if !stepResults.isEmpty {
      storage._stepResults = stepResults
    }
    if let v = version {
      storage._version = v
    }
    if let v = surveyType {
      storage._surveyType = v
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    return try _uniqueStorage().decodeField(setter: &setter, protoFieldNumber: protoFieldNumber)
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    try _storage.traverse(visitor: &visitor)
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_Result) -> Bool {
    return _storage === other._storage || _storage.isEqualTo(other: other._storage)
  }

  private mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _storage.copy()
    }
    return _storage
  }
}

public struct Otsimo_DeviceInfo: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_DeviceInfo"}
  public var protoMessageName: String {return "DeviceInfo"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "vendorId": 1,
    "bundleIdentifier": 3,
    "bundleVersion": 4,
    "bundleShortVersion": 5,
    "deviceType": 6,
    "deviceName": 7,
    "osName": 8,
    "systemVersion": 9,
    "languageCode": 10,
    "countryCode": 11,
    "ip": 12,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "vendorId": 1,
    "bundleIdentifier": 3,
    "bundleVersion": 4,
    "bundleShortVersion": 5,
    "deviceType": 6,
    "deviceName": 7,
    "osName": 8,
    "systemVersion": 9,
    "languageCode": 10,
    "countryCode": 11,
    "ip": 12,
  ]}

  public var vendorId: String = ""

  public var bundleIdentifier: String = ""

  public var bundleVersion: String = ""

  public var bundleShortVersion: String = ""

  public var deviceType: String = ""

  public var deviceName: String = ""

  public var osName: String = ""

  public var systemVersion: String = ""

  public var languageCode: String = ""

  public var countryCode: String = ""

  public var ip: String = ""

  public init() {}

  public init(vendorId: String? = nil,
    bundleIdentifier: String? = nil,
    bundleVersion: String? = nil,
    bundleShortVersion: String? = nil,
    deviceType: String? = nil,
    deviceName: String? = nil,
    osName: String? = nil,
    systemVersion: String? = nil,
    languageCode: String? = nil,
    countryCode: String? = nil,
    ip: String? = nil)
  {
    if let v = vendorId {
      self.vendorId = v
    }
    if let v = bundleIdentifier {
      self.bundleIdentifier = v
    }
    if let v = bundleVersion {
      self.bundleVersion = v
    }
    if let v = bundleShortVersion {
      self.bundleShortVersion = v
    }
    if let v = deviceType {
      self.deviceType = v
    }
    if let v = deviceName {
      self.deviceName = v
    }
    if let v = osName {
      self.osName = v
    }
    if let v = systemVersion {
      self.systemVersion = v
    }
    if let v = languageCode {
      self.languageCode = v
    }
    if let v = countryCode {
      self.countryCode = v
    }
    if let v = ip {
      self.ip = v
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    let handled: Bool
    switch protoFieldNumber {
    case 1: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &vendorId)
    case 3: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &bundleIdentifier)
    case 4: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &bundleVersion)
    case 5: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &bundleShortVersion)
    case 6: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &deviceType)
    case 7: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &deviceName)
    case 8: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &osName)
    case 9: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &systemVersion)
    case 10: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &languageCode)
    case 11: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &countryCode)
    case 12: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &ip)
    default:
      handled = false
    }
    return handled
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    if vendorId != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: vendorId, protoFieldNumber: 1, protoFieldName: "vendorId", jsonFieldName: "vendorId", swiftFieldName: "vendorId")
    }
    if bundleIdentifier != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: bundleIdentifier, protoFieldNumber: 3, protoFieldName: "bundleIdentifier", jsonFieldName: "bundleIdentifier", swiftFieldName: "bundleIdentifier")
    }
    if bundleVersion != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: bundleVersion, protoFieldNumber: 4, protoFieldName: "bundleVersion", jsonFieldName: "bundleVersion", swiftFieldName: "bundleVersion")
    }
    if bundleShortVersion != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: bundleShortVersion, protoFieldNumber: 5, protoFieldName: "bundleShortVersion", jsonFieldName: "bundleShortVersion", swiftFieldName: "bundleShortVersion")
    }
    if deviceType != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: deviceType, protoFieldNumber: 6, protoFieldName: "deviceType", jsonFieldName: "deviceType", swiftFieldName: "deviceType")
    }
    if deviceName != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: deviceName, protoFieldNumber: 7, protoFieldName: "deviceName", jsonFieldName: "deviceName", swiftFieldName: "deviceName")
    }
    if osName != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: osName, protoFieldNumber: 8, protoFieldName: "osName", jsonFieldName: "osName", swiftFieldName: "osName")
    }
    if systemVersion != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: systemVersion, protoFieldNumber: 9, protoFieldName: "systemVersion", jsonFieldName: "systemVersion", swiftFieldName: "systemVersion")
    }
    if languageCode != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: languageCode, protoFieldNumber: 10, protoFieldName: "languageCode", jsonFieldName: "languageCode", swiftFieldName: "languageCode")
    }
    if countryCode != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: countryCode, protoFieldNumber: 11, protoFieldName: "countryCode", jsonFieldName: "countryCode", swiftFieldName: "countryCode")
    }
    if ip != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: ip, protoFieldNumber: 12, protoFieldName: "ip", jsonFieldName: "ip", swiftFieldName: "ip")
    }
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_DeviceInfo) -> Bool {
    if vendorId != other.vendorId {return false}
    if bundleIdentifier != other.bundleIdentifier {return false}
    if bundleVersion != other.bundleVersion {return false}
    if bundleShortVersion != other.bundleShortVersion {return false}
    if deviceType != other.deviceType {return false}
    if deviceName != other.deviceName {return false}
    if osName != other.osName {return false}
    if systemVersion != other.systemVersion {return false}
    if languageCode != other.languageCode {return false}
    if countryCode != other.countryCode {return false}
    if ip != other.ip {return false}
    return true
  }
}

public struct Otsimo_Info: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_Info"}
  public var protoMessageName: String {return "Info"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "birthDay": 1,
    "gender": 2,
    "relation": 3,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "birthDay": 1,
    "gender": 2,
    "relation": 3,
  ]}

  public var birthDay: Int64 = 0

  public var gender: String = ""

  public var relation: String = ""

  public init() {}

  public init(birthDay: Int64? = nil,
    gender: String? = nil,
    relation: String? = nil)
  {
    if let v = birthDay {
      self.birthDay = v
    }
    if let v = gender {
      self.gender = v
    }
    if let v = relation {
      self.relation = v
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    let handled: Bool
    switch protoFieldNumber {
    case 1: handled = try setter.decodeSingularField(fieldType: ProtobufInt64.self, value: &birthDay)
    case 2: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &gender)
    case 3: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &relation)
    default:
      handled = false
    }
    return handled
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    if birthDay != 0 {
      try visitor.visitSingularField(fieldType: ProtobufInt64.self, value: birthDay, protoFieldNumber: 1, protoFieldName: "birthDay", jsonFieldName: "birthDay", swiftFieldName: "birthDay")
    }
    if gender != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: gender, protoFieldNumber: 2, protoFieldName: "gender", jsonFieldName: "gender", swiftFieldName: "gender")
    }
    if relation != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: relation, protoFieldNumber: 3, protoFieldName: "relation", jsonFieldName: "relation", swiftFieldName: "relation")
    }
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_Info) -> Bool {
    if birthDay != other.birthDay {return false}
    if gender != other.gender {return false}
    if relation != other.relation {return false}
    return true
  }
}

public struct Otsimo_UserInfo: ProtobufGeneratedMessage {
  public var swiftClassName: String {return "Otsimo_UserInfo"}
  public var protoMessageName: String {return "UserInfo"}
  public var protoPackageName: String {return "otsimo"}
  public var jsonFieldNames: [String: Int] {return [
    "userID": 1,
    "email": 2,
  ]}
  public var protoFieldNames: [String: Int] {return [
    "userID": 1,
    "email": 2,
  ]}

  public var userId: String = ""

  public var email: String = ""

  public init() {}

  public init(userId: String? = nil,
    email: String? = nil)
  {
    if let v = userId {
      self.userId = v
    }
    if let v = email {
      self.email = v
    }
  }

  public mutating func _protoc_generated_decodeField(setter: inout ProtobufFieldDecoder, protoFieldNumber: Int) throws -> Bool {
    let handled: Bool
    switch protoFieldNumber {
    case 1: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &userId)
    case 2: handled = try setter.decodeSingularField(fieldType: ProtobufString.self, value: &email)
    default:
      handled = false
    }
    return handled
  }

  public func _protoc_generated_traverse(visitor: inout ProtobufVisitor) throws {
    if userId != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: userId, protoFieldNumber: 1, protoFieldName: "userID", jsonFieldName: "userID", swiftFieldName: "userId")
    }
    if email != "" {
      try visitor.visitSingularField(fieldType: ProtobufString.self, value: email, protoFieldNumber: 2, protoFieldName: "email", jsonFieldName: "email", swiftFieldName: "email")
    }
  }

  public func _protoc_generated_isEqualTo(other: Otsimo_UserInfo) -> Bool {
    if userId != other.userId {return false}
    if email != other.email {return false}
    return true
  }
}
