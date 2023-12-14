
//
//  ScenarioResponse.swift
//  PocketLab-iOS
//
//  Created by Youbaraj POUDEL on 08/09/2023.
//

import Foundation

//// MARK: - CerealType
public struct PackageCerealType: Codable {
    public let id: Int?
    public let generalName, slug, createdAt, updatedAt: String?
    public let iconForegroundHexColor, iconBackgroundHexColor: String?
    public let textID: Int?
    public let names: [PackageName]?

     enum CodingKeys: String, CodingKey {
        case id, generalName, slug, createdAt, updatedAt, iconForegroundHexColor, iconBackgroundHexColor
        case textID = "textId"
        case names
    }
    
     var dictionaryRepresentation: [String: Any] {
        return [
            "id": id ?? 0,
            "generalName": generalName ?? "",
            "slug": slug ?? "",
            "createdAt": createdAt ?? "",
            "updatedAt": updatedAt ?? "",
            "iconForegroundHexColor": iconForegroundHexColor ?? "",
            "iconBackgroundHexColor": iconBackgroundHexColor ?? "",
            "textId": textID ?? 0,
            "names": names?.map { $0.dictionaryRepresentation } ?? []
        ]
    }
    
}
//
//// MARK: - Name
public struct PackageName: Codable {
    public let id, cerealTypeID: Int?
    public let name, locale: String?
    public let ownerOrgID: Int?
    public var createdAt, updatedAt: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case cerealTypeID = "cerealTypeId"
        case name, locale
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt
    }
    
    public var dictionaryRepresentation: [String: Any] {
         return [
             "id": id ?? 0,
             "cerealTypeId": cerealTypeID ?? 0,
             "name": name ?? "",
             "locale": locale ?? "",
             "ownerOrgId": ownerOrgID ?? 0,
             "createdAt": createdAt ?? "",
             "updatedAt": updatedAt ?? ""
         ]
     }
}

// MARK: - Welcome
public struct PackageScenarioResponseParent: Codable {
    public let total, limit, skip: Int?
    public let data: [PackageScenarioResponse]?
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "total": total as Any,
            "limit": limit as Any,
            "skip": skip as Any,
            "data": data?.map { $0.dictionaryRepresentation } ?? []
        ]
    }
}

// MARK: - Datum
public struct PackageScenarioResponse: Codable {
    public let id: Int?
    public let name, description: String?
    public let status: Int?
    public let creatorID: String?
    public let ownerOrgID: Int?
    public let createdAt, updatedAt: String?
    public let cerealTypeID, lastScenarioInstanceID: Int?
    public let slug: String?
    public let orderIndex, iconSalt: Int?
    public let isSystemScenario: Bool?
    public let statusConstantID: Int?
    public var cerealType: PackageCerealType?
    public let latestScenarioInstance: PackageLatestScenarioInstance?

    public enum CodingKeys: String, CodingKey {
        case id, name, description, status
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt
        case cerealTypeID = "cerealTypeId"
        case lastScenarioInstanceID = "lastScenarioInstanceId"
        case slug, orderIndex, iconSalt, isSystemScenario
        case statusConstantID = "statusConstantId"
        case cerealType, latestScenarioInstance
    }
    
    
    var dictionaryRepresentation: [String: Any] {
          return [
              "id": id ?? "",
              "name": name ?? "",
              "description": description ?? "",
              "status": status ?? 0,
              "creatorId": creatorID ?? "",
              "ownerOrgId": ownerOrgID ?? 0,
              "createdAt": createdAt ?? "",
              "updatedAt": updatedAt ?? "",
              "cerealTypeId": cerealTypeID ?? 0,
              "lastScenarioInstanceId": lastScenarioInstanceID ?? 0,
              "slug": slug ?? "",
              "orderIndex": orderIndex ?? 0,
              "iconSalt": iconSalt ?? 0,
              "isSystemScenario": isSystemScenario ?? false,
              "statusConstantId": statusConstantID ?? 0,
//              "cerealType": PackageCerealType?.dictionaryRepresentation ?? [:],
//              "latestScenarioInstance": PackageLatestScenarioInstance?.dictionaryRepresentation ?? [:]
          ]
      }
}

//// MARK: - CerealType
//public struct CerealType: Codable {
//    public let id: Int?
//    public let name, description, icon: String?
//    public let isActive: Bool?
//    public let createdAt, updatedAt: String?
//}



// MARK: - LatestScenarioInstance
public struct PackageLatestScenarioInstance: Codable {
  public let id, scenarioID: Int?
    public  let creatorID: String?
    public  let ownerOrgID: Int?
//public    let deletedAt: JSONNull?
    public  let createdAt, updatedAt: String?
    public  let isArchived: Bool?
    public  let steps: [String]?
//public    let config: JSONNull?
    public  let scenarioInstanceSteps: [ScenarioInstanceStep]?

    enum CodingKeys: String, CodingKey {
        case id
        case scenarioID = "scenarioId"
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt, isArchived, steps, scenarioInstanceSteps
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "id": id ?? 0,
            "scenarioId": scenarioID ?? 0,
            "creatorId": creatorID ?? "",
            "ownerOrgId": ownerOrgID ?? 0,
            "createdAt": createdAt ?? "",
            "updatedAt": updatedAt ?? "",
            "isArchived": isArchived ?? false,
            "steps": steps ?? [],
            "scenarioInstanceSteps": scenarioInstanceSteps?.map { $0.dictionaryRepresentation } ?? []
        ]
    }
}


// MARK: - ScenarioInstanceStep
public struct ScenarioInstanceStep: Codable {
    public let id: Int?
    public let slug, screenSlug, description: String?
    public let config: Config?
    public let hidden: Bool?
    public let labelTemplateID, predictionPostProcessingRuleID: Int?
    public let createdAt, updatedAt, userFacingShortName: String?
    public let userFacingInstruction: String?
    public let userFacingShortNameTextID: Int?
//  public   let userFacingInstructionTextID: JSONNull?
    public let v2LabelTemplateID: String?
    public let userFacingShortNameText: UserFacing?
    public let labelTemplate: LabelTemplate?
    public let predictionPostProcessingRule: PredictionPostProcessingRule?
//  public   let userFacingInstructionText: JSONNull?
    public let v2LabelTemplate: V2LabelTemplate?

    public  enum CodingKeys: String, CodingKey {
        case id, slug, screenSlug, description, config, hidden
        case labelTemplateID = "labelTemplateId"
        case predictionPostProcessingRuleID = "predictionPostProcessingRuleId"
        case createdAt, updatedAt, userFacingShortName, userFacingInstruction
        case userFacingShortNameTextID = "userFacingShortNameTextId"
        case v2LabelTemplateID = "v2LabelTemplateId"
        case userFacingShortNameText, labelTemplate, predictionPostProcessingRule, v2LabelTemplate
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "id": id ?? 0,
            "slug": slug ?? "",
            "screenSlug": screenSlug ?? "",
            "description": description ?? "",
            "config": config?.dictionaryRepresentation ?? [:],
            "hidden": hidden ?? false,
            "labelTemplateId": labelTemplateID ?? 0,
            "predictionPostProcessingRuleId": predictionPostProcessingRuleID ?? 0,
            "createdAt": createdAt ?? "",
            "updatedAt": updatedAt ?? "",
            "userFacingShortName": userFacingShortName ?? "",
            "userFacingInstruction": userFacingInstruction ?? "",
            "userFacingShortNameTextId": userFacingShortNameTextID ?? 0,
            "v2LabelTemplateId": v2LabelTemplateID ?? "",
            "userFacingShortNameText": userFacingShortNameText?.dictionaryRepresentation ?? [:],
            "labelTemplate": labelTemplate?.dictionaryRepresentation ?? [:],
            "predictionPostProcessingRule": predictionPostProcessingRule?.dictionaryRepresentation ?? [:],
            "v2LabelTemplate": v2LabelTemplate?.dictionaryRepresentation ?? [:]
            
        ]
    }
}

// MARK: - Config
public struct Config: Codable {
    public let mandatory: Bool?
    public let crop: Crop?
    public let nbImages: Int?
    public let imageQuality: Double?
    public let imageInterval: Int?
    public let logToImageMetadata: ConfigLogToImageMetadata?
    public let deviceSpecificOverride: [DeviceSpecificOverride]?
    public let configRequired, manual, barCode: Bool?
    public let preference: String?
    public let autoGenerate: Bool?
    public let jumpToScenario: [JumpToScenario]?

    public enum CodingKeys: String, CodingKey {
        case mandatory, crop, nbImages, imageQuality, imageInterval
        case logToImageMetadata = "log_to.image.metadata"
        case deviceSpecificOverride = "device-specific-override"
        case configRequired = "required"
        case manual, barCode, preference, autoGenerate, jumpToScenario
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "mandatory": mandatory ?? false,
            "crop": crop?.dictionaryRepresentation ?? [:],
            "nbImages": nbImages ?? 0,
            "imageQuality": imageQuality ?? 0.0,
            "imageInterval": imageInterval ?? 0,
            "logToImageMetadata": logToImageMetadata?.dictionaryRepresentation ?? [:],
            "deviceSpecificOverride": deviceSpecificOverride?.map { $0.dictionaryRepresentation } ?? [],
            "configRequired": configRequired ?? false,
            "manual": manual ?? false,
            "barCode": barCode ?? false,
            "preference": preference ?? "",
            "autoGenerate": autoGenerate ?? false,
            "jumpToScenario": jumpToScenario?.map { $0.dictionaryRepresentation } ?? []
            
        ]
    }
}

// MARK: - Crop
public struct Crop: Codable {
    public let width, height: Int?
    
    var dictionaryRepresentation: [String: Any] {
          return [
              "width": width as Any,
              "height": height as Any
              
          ]
      }
    
}

// MARK: - DeviceSpecificOverride
public struct DeviceSpecificOverride: Codable {
    public let matching: Matching?
    public let configReplace: ConfigReplace?

    enum CodingKeys: String, CodingKey {
        case matching
        case configReplace = "config-replace"
    }
    
    var dictionaryRepresentation: [String: Any] {
         return [
             "matching": matching?.dictionaryRepresentation ?? [:],
             "configReplace": configReplace?.dictionaryRepresentation ?? [:]
             
         ]
     }
}

// MARK: - ConfigReplace
public struct ConfigReplace: Codable {
    public let crop: SubstitutionDictV2?
    public let nbImages: Int?
    public let imageQuality: Double?
    public let logToImageMetadata: ConfigReplaceLogToImageMetadata?
    public let drawGuide: DrawGuide?
    public let imageInterval: Int?
    public let addUserGuideline: AddUserGuideline?
    public let flashMode: String?

    enum CodingKeys: String, CodingKey {
        case crop, nbImages, imageQuality
        case logToImageMetadata = "log_to.image.metadata"
        case drawGuide = "draw-guide"
        case imageInterval
        case addUserGuideline = "add-user-guideline"
        case flashMode
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "crop": crop?.dictionaryRepresentation ?? [:],
            "nbImages": nbImages as Any,
            "imageQuality": imageQuality as Any,
            "logToImageMetadata": logToImageMetadata?.dictionaryRepresentation ?? [:],
            "drawGuide": drawGuide?.dictionaryRepresentation ?? [:],
            "imageInterval": imageInterval as Any,
            "addUserGuideline": addUserGuideline?.dictionaryRepresentation ?? [:],
            "flashMode": flashMode as Any
            
        ]
    }
}

// MARK: - AddUserGuideline
public struct AddUserGuideline: Codable {
    public let de, en, fr: String?
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "de": de as Any,
            "en": en as Any,
            "fr": fr as Any
        ]
    }
}

// MARK: - SubstitutionDictV2
public struct SubstitutionDictV2: Codable {
    public let optionalArray: [OptionalArray]?
    
    var dictionaryRepresentation: [String: Any] {
           return [
               "optionalArray": optionalArray?.map { $0.dictionaryRepresentation } ?? []
           ]
       }
}

// MARK: - DrawGuide
public struct DrawGuide: Codable {
    public let type: String?
    public let width, height: Int?
    public let position: String?
    
    var dictionaryRepresentation: [String: Any] {
         return [
             "type": type as Any,
             "width": width as Any,
             "height": height as Any,
             "position": position as Any
         ]
     }
}

// MARK: - ConfigReplaceLogToImageMetadata
public struct ConfigReplaceLogToImageMetadata: Codable {
    public let deviceType, acquisitionType: String?
    public let expectedDistance: Double?

    enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
        case acquisitionType = "acquisition_type"
        case expectedDistance = "expected_distance"
    }
    
    var dictionaryRepresentation: [String: Any] {
           return [
               "deviceType": deviceType as Any,
               "acquisitionType": acquisitionType as Any,
               "expectedDistance": expectedDistance as Any
           ]
       }
}

// MARK: - Matching
public struct Matching: Codable {
    public let deviceModelName: DeviceModelName?
    public let deviceManufacturer: String?

    enum CodingKeys: String, CodingKey {
        case deviceModelName = "Device.modelName"
        case deviceManufacturer = "Device.manufacturer"
    }
    
    var dictionaryRepresentation: [String: Any] {
         return [
             "deviceModelName": deviceModelName?.dictionaryRepresentation ?? [:],
             "deviceManufacturer": deviceManufacturer as Any
         ]
     }
}

public enum DeviceModelName: Codable {
    case string(String)
    case stringArray([String])

    public  init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(DeviceModelName.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DeviceModelName"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
    
    var dictionaryRepresentation: [String: Any] {
        switch self {
        case .string(let value):
            return ["value": value]
        case .stringArray(let values):
            return ["values": values]
        }
    }
}

// MARK: - JumpToScenario
public struct JumpToScenario: Codable {
    public let jumpType: String?
    public let jumpTitle, jumpMessage, jumpButtonName: EndOfRecursionCommentExplanation?
    public let conditionPredValue: [String]?
    public let selfChainRetriesLimit: Int?
    public let ignorePreviousDeclarations: Bool?
    public let endOfRecursionCommentExplanation: EndOfRecursionCommentExplanation?
    public let scenarioID: Int?

    enum CodingKeys: String, CodingKey {
        case jumpType, jumpTitle, jumpMessage, jumpButtonName, conditionPredValue, selfChainRetriesLimit, ignorePreviousDeclarations, endOfRecursionCommentExplanation
        case scenarioID = "scenarioId"
    }
    
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "jumpType": jumpType as Any,
            "jumpTitle": jumpTitle?.dictionaryRepresentation ?? [:],
            "jumpMessage": jumpMessage?.dictionaryRepresentation ?? [:],
            "jumpButtonName": jumpButtonName?.dictionaryRepresentation ?? [:],
            "conditionPredValue": conditionPredValue as Any,
            "selfChainRetriesLimit": selfChainRetriesLimit as Any,
            "ignorePreviousDeclarations": ignorePreviousDeclarations as Any,
            "endOfRecursionCommentExplanation": endOfRecursionCommentExplanation?.dictionaryRepresentation ?? [:],
            "scenarioID": scenarioID as Any
        ]
    }
}

// MARK: - EndOfRecursionCommentExplanation
public struct EndOfRecursionCommentExplanation: Codable {
    public let en, fr: String?
    
    public var dictionaryRepresentation: [String: Any] {
        return [
            "en": en as Any,
            "fr": fr as Any
        ]
    }

}

// MARK: - ConfigLogToImageMetadata
public struct ConfigLogToImageMetadata: Codable {
    public  let deviceType, acquisitionType: String?

    public enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
        case acquisitionType = "acquisition_type"
    }
    
    public var dictionaryRepresentation: [String: Any] {
         return [
             "deviceType": deviceType as Any,
             "acquisitionType": acquisitionType as Any
         ]
     }
}

// MARK: - LabelTemplate
public struct LabelTemplate: Codable {
    public let id: Int?
    public let slug, creatorID: String?
    public let ownerOrgID: Int?
    public let property, description: String?
    public let typeID: Int?
//  public   let unit: JSONNull?
    public let possibleClasses: [String]?
//  public   let valueBounds: JSONNull?
    public let createdAt, updatedAt, customerFacingName: String?

    public enum CodingKeys: String, CodingKey {
        case id, slug
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case property, description
        case typeID = "typeId"
        case possibleClasses, createdAt, updatedAt, customerFacingName
    }
    
    public var dictionaryRepresentation: [String: Any] {
         return [
             "id": id as Any,
             "slug": slug as Any,
             "creatorID": creatorID as Any,
             "ownerOrgID": ownerOrgID as Any,
             "property": property as Any,
             "description": description as Any,
             "typeID": typeID as Any,
             "possibleClasses": possibleClasses as Any,
             "createdAt": createdAt as Any,
             "updatedAt": updatedAt as Any,
             "customerFacingName": customerFacingName as Any
         ]
     }
}

// MARK: - PredictionPostProcessingRule
public struct PredictionPostProcessingRule: Codable {
    public let id: Int?
    public let slug, customerFacingName: String?
    public let substitutionDict: PredictionPostProcessingRuleSubstitutionDict?
    public let advancedProcessingID: Int?
    public let creatorID: String?
    public let ownerOrgID: Int?
    public let createdAt, updatedAt: String?
    public let advancedProcessingConfig: AdvancedProcessingConfig?
    public let userFacingNameTextID: Int?
     //    let shadowAdvProcessingConfig: JSONNull?
    public let userFacingIconConstantID: Int?
    public let userFacingName: UserFacing?
    public let userFacingIcon: UserFacingIcon?

    public enum CodingKeys: String, CodingKey {
        case id, slug, customerFacingName, substitutionDict
        case advancedProcessingID = "advancedProcessingId"
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt, advancedProcessingConfig
        case userFacingNameTextID = "userFacingNameTextId"
//        case shadowAdvProcessingConfig
        case userFacingIconConstantID = "userFacingIconConstantId"
        case userFacingName, userFacingIcon
    }
    
    public var dictionaryRepresentation: [String: Any] {
          return [
              "id": id as Any,
              "slug": slug as Any,
              "customerFacingName": customerFacingName as Any,
              "substitutionDict": substitutionDict?.dictionaryRepresentation ?? [:],
              "advancedProcessingID": advancedProcessingID as Any,
              "creatorID": creatorID as Any,
              "ownerOrgID": ownerOrgID as Any,
              "createdAt": createdAt as Any,
              "updatedAt": updatedAt as Any,
              "advancedProcessingConfig": advancedProcessingConfig?.dictionaryRepresentation ?? [:],
              "userFacingNameTextID": userFacingNameTextID as Any,
              "userFacingIconConstantID": userFacingIconConstantID as Any,
              "userFacingName": userFacingName?.dictionaryRepresentation ?? [:],
              "userFacingIcon": userFacingIcon?.dictionaryRepresentation ?? [:]
          ]
      }
}

// MARK: - AdvancedProcessingConfig
public struct AdvancedProcessingConfig: Codable {
    public let unit: String?
    public let thresholds: [Threshold]?
    public let useRounding: Bool?
    public let minConfidence: Double?
    public let floatPrecision: Int?
    public let exportedMeasureName: String?
    public let minGrainCountPerImage: Int?

    public var dictionaryRepresentation: [String: Any] {
        return [
            "unit": unit as Any,
            "thresholds": thresholds?.map { $0.dictionaryRepresentation } ?? [],
            "useRounding": useRounding as Any,
            "minConfidence": minConfidence as Any,
            "floatPrecision": floatPrecision as Any,
            "exportedMeasureName": exportedMeasureName as Any,
            "minGrainCountPerImage": minGrainCountPerImage as Any
            // Add more properties as needed
        ]
    }
}

// MARK: - Threshold
public struct Threshold: Codable {
    public let lowerBound, upperBound: Double?
    public let displayName: String?
//    let exportedValue: JSONNull?
    
    public  var dictionaryRepresentation: [String: Any] {
        return [
            "lowerBound": lowerBound as Any,
            "upperBound": upperBound as Any,
            "displayName": displayName as Any
            // Add more properties as needed
        ]
    }
}

// MARK: - PredictionPostProcessingRuleSubstitutionDict
public struct PredictionPostProcessingRuleSubstitutionDict: Codable {
    public let notRecognised, substitutionDictNotRecognised, badAcquisition, substitutionDictBadAcquisition: String?
    public let badAcquisitionTooFar, substitutionDictBadAcquisitionTooFar, badAcquisitionTooClose, substitutionDictBadAcquisitionTooClose: String?
    public  let riskMix, substitutionDictRiskMix: String?

    public enum CodingKeys: String, CodingKey {
        case notRecognised = "not-recognised"
        case substitutionDictNotRecognised = "not_recognised"
        case badAcquisition = "bad-acquisition"
        case substitutionDictBadAcquisition = "bad_acquisition"
        case badAcquisitionTooFar = "bad-acquisition-too-far"
        case substitutionDictBadAcquisitionTooFar = "bad_acquisition_too_far"
        case badAcquisitionTooClose = "bad-acquisition-too-close"
        case substitutionDictBadAcquisitionTooClose = "bad_acquisition_too_close"
        case riskMix = "risk-mix"
        case substitutionDictRiskMix = "risk_mix"
    }
    
    public  var dictionaryRepresentation: [String: Any] {
        return [
            "notRecognised": notRecognised as Any,
            "substitutionDictNotRecognised": substitutionDictNotRecognised as Any,
            "badAcquisition": badAcquisition as Any,
            "substitutionDictBadAcquisition": substitutionDictBadAcquisition as Any,
            "badAcquisitionTooFar": badAcquisitionTooFar as Any,
            "substitutionDictBadAcquisitionTooFar": substitutionDictBadAcquisitionTooFar as Any,
            "badAcquisitionTooClose": badAcquisitionTooClose as Any,
            "substitutionDictBadAcquisitionTooClose": substitutionDictBadAcquisitionTooClose as Any,
            "riskMix": riskMix as Any,
            "substitutionDictRiskMix": substitutionDictRiskMix as Any
            // Add more properties as needed
        ]
    }
}

// MARK: - UserFacingIcon
public struct UserFacingIcon: Codable {
    public let id: Int?
    public let value: String?
    public let originTableName: UserFacingIconOriginTableName?
    public let createdBy, createdAt, updatedAt: String?
    
    public var dictionaryRepresentation: [String: Any] {
        return [
            "id": id as Any,
            "value": value as Any,
            "originTableName": originTableName?.rawValue as Any,
            "createdBy": createdBy as Any,
            "createdAt": createdAt as Any,
            "updatedAt": updatedAt as Any
            // Add more properties as needed
        ]
    }
}

public enum UserFacingIconOriginTableName: String, Codable {
    case coreLocalizedText = "core.localized_text"
    case corePredictionPostProcessingRule = "core.prediction_post_processing_rule"
    case labelsV2LabelTemplate = "labels.v2_label_template"
}

// MARK: - UserFacing
public struct UserFacing: Codable {
    public let id: Int?
    public let slug: String?
    public let originTableName: UserFacingShortNameTextOriginTableName?
    public let createdAt, updatedAt: String?
    public let localizedTexts: [LocalizedText]?
    
    var dictionaryRepresentation: [String: Any] {
         return [
             "id": id as Any,
             "slug": slug as Any,
             "originTableName": originTableName?.rawValue as Any,
             "createdAt": createdAt as Any,
             "updatedAt": updatedAt as Any,
             "localizedTexts": localizedTexts?.map { $0.dictionaryRepresentation } ?? []
             // Add more properties as needed
         ]
     }
}

// MARK: - LocalizedText
public struct LocalizedText: Codable {
    public let id: String?
    public let textID, localeConstantID: Int?
    public let translation, createdAt, updatedAt: String?
    public let locale: UserFacingIcon?

    enum CodingKeys: String, CodingKey {
        case id
        case textID = "textId"
        case localeConstantID = "localeConstantId"
        case translation, createdAt, updatedAt, locale
    }
    
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "id": id as Any,
            "textID": textID as Any,
            "localeConstantID": localeConstantID as Any,
            "translation": translation as Any,
            "createdAt": createdAt as Any,
            "updatedAt": updatedAt as Any,
            "locale": locale?.dictionaryRepresentation ?? [:]
            // Add more properties as needed
        ]
    }
}

public enum UserFacingShortNameTextOriginTableName: String, Codable {
    case corePredictionPostProcessingRule = "core.prediction_post_processing_rule"
    case coreScenarioInstanceStep = "core.scenario_instance_step"
    case labelsV2LabelTemplateConfig = "labels.v2_label_template_config"
}

// MARK: - V2LabelTemplate
public struct V2LabelTemplate: Codable {
    public  let generatedByLabelTemplateConfig: GeneratedByLabelTemplateConfig?
//public    let labelInstanceMetadataSeed: JSONNull?
    public  let labelTemplateID, labelTemplateVersionID: String?
    public  let possibleClasses: [String]?
//public    let valueBounds: JSONNull?
    public  let typeConstantID, scopeConstantID: Int?
    public  let type, scope: UserFacingIcon?
    public  let unit: String?

    enum CodingKeys: String, CodingKey {
        case generatedByLabelTemplateConfig
        case labelTemplateID = "labelTemplateId"
        case labelTemplateVersionID = "labelTemplateVersionId"
        case possibleClasses
        case typeConstantID = "typeConstantId"
        case scopeConstantID = "scopeConstantId"
        case type, scope, unit
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "generatedByLabelTemplateConfig": generatedByLabelTemplateConfig?.dictionaryRepresentation ?? [:],
            "labelTemplateID": labelTemplateID as Any,
            "labelTemplateVersionID": labelTemplateVersionID as Any,
            "possibleClasses": possibleClasses as Any,
            "typeConstantID": typeConstantID as Any,
            "scopeConstantID": scopeConstantID as Any,
            "type": type?.dictionaryRepresentation ?? [:],
            "scope": scope?.dictionaryRepresentation ?? [:],
            "unit": unit as Any
            // Add more properties as needed
        ]
    }
}

// MARK: - GeneratedByLabelTemplateConfig
public struct GeneratedByLabelTemplateConfig: Codable {
    public  var id, slug, labelTemplateID: String?
    public  let scopeOrgID: Int?
//public    let scopeScenarioID, scopeScenarioStepID: JSONNull?
    public  let userFacingNameTextID: Int?
    public  let substitutionDict: GeneratedByLabelTemplateConfigSubstitutionDict?
//public    let valueFormater: JSONNull?
    public  let createdBy, updatedBy: String?
//public    let archivedBy: JSONNull?
    public  let createdAt, updatedAt: String?
//public    let archivedAt, labelInstanceMetadataSeed: JSONNull?
    public  let substitutionDictV2: SubstitutionDictV2?
    public  let userFacingName: UserFacing?

    public enum CodingKeys: String, CodingKey {
        case id, slug
        case labelTemplateID = "labelTemplateId"
        case scopeOrgID = "scopeOrgId"
        case userFacingNameTextID = "userFacingNameTextId"
        case substitutionDict, createdBy, updatedBy, createdAt, updatedAt, substitutionDictV2, userFacingName
    }
    
    public var dictionaryRepresentation: [String: Any] {
        return [
            "id": id as Any,
            "slug": slug as Any,
            "labelTemplateID": labelTemplateID as Any,
            "scopeOrgID": scopeOrgID as Any,
            "userFacingNameTextID": userFacingNameTextID as Any,
            "substitutionDict": substitutionDict?.dictionaryRepresentation ?? [:],
            "createdBy": createdBy as Any,
            "updatedBy": updatedBy as Any,
            "createdAt": createdAt as Any,
            "updatedAt": updatedAt as Any,
            "substitutionDictV2": substitutionDictV2?.dictionaryRepresentation ?? [:],
            "userFacingName": userFacingName?.dictionaryRepresentation ?? [:]
            // Add more properties as needed
        ]
    }
}

// MARK: - GeneratedByLabelTemplateConfigSubstitutionDict
public struct GeneratedByLabelTemplateConfigSubstitutionDict: Codable {
    public let faro, tosca, planet, amidala: String?
    public let melange, dementiel, varieteAutre: String?

    public enum CodingKeys: String, CodingKey {
        case faro = "Faro"
        case tosca = "Tosca"
        case planet = "Planet"
        case amidala = "Amidala"
        case melange = "Melange"
        case dementiel = "Dementiel"
        case varieteAutre = "Variete autre"
    }
    
    
    public var dictionaryRepresentation: [String: Any] {
        return [
            "faro": faro as Any,
            "tosca": tosca as Any,
            "planet": planet as Any,
            "amidala": amidala as Any,
            "melange": melange as Any,
            "dementiel": dementiel as Any,
            "varieteAutre": varieteAutre as Any
            // Add more properties as needed
        ]
    }
}

public struct OptionalArray: Codable, Identifiable {
    public var id: UUID? = UUID()
    public let dataValue, userValue: String?

    public init(id: UUID = UUID(), dataValue: String?, userValue: String?) {
        self.id = id
        self.dataValue = dataValue
        self.userValue = userValue
    }
    
    var dictionaryRepresentation: [String: Any] {
           return [
               "id": id?.uuidString ?? "",
               "dataValue": dataValue ?? "",
               "userValue": userValue ?? ""
           ]
       }
}
