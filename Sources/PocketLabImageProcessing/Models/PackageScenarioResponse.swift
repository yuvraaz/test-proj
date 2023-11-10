
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
}
//
//// MARK: - Name
public struct PackageName: Codable {
    public let id, cerealTypeID: Int?
    public let name, locale: String?
    public let ownerOrgID: Int?
    public  var createdAt, updatedAt: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case cerealTypeID = "cerealTypeId"
        case name, locale
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt
    }
}

// MARK: - Welcome
public struct PackageScenarioResponseParent: Codable {
    public let total, limit, skip: Int?
    public let data: [PackageScenarioResponse]?
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
    public let id: Int?
    public let status: Int?
    public let scenarioID: Int?
    public let createdAt, updatedAt: String?
    public let lastEditByUserID: Int?
    public let orgID: Int?

    public enum CodingKeys: String, CodingKey {
        case id, status
        case scenarioID = "scenarioId"
        case createdAt, updatedAt
        case lastEditByUserID = "lastEditByUserId"
        case orgID = "orgId"
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
}

// MARK: - Crop
public struct Crop: Codable {
    public let width, height: Int?
}

// MARK: - DeviceSpecificOverride
public struct DeviceSpecificOverride: Codable {
    public let matching: Matching?
    public let configReplace: ConfigReplace?

    public enum CodingKeys: String, CodingKey {
        case matching
        case configReplace = "config-replace"
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

    public enum CodingKeys: String, CodingKey {
        case crop, nbImages, imageQuality
        case logToImageMetadata = "log_to.image.metadata"
        case drawGuide = "draw-guide"
        case imageInterval
        case addUserGuideline = "add-user-guideline"
        case flashMode
    }
}

// MARK: - AddUserGuideline
public struct AddUserGuideline: Codable {
    public let de, en, fr: String?
}

// MARK: - SubstitutionDictV2
public struct SubstitutionDictV2: Codable {
}

// MARK: - DrawGuide
public struct DrawGuide: Codable {
    public let type: String?
    public let width, height: Int?
    public let position: String?
}

// MARK: - ConfigReplaceLogToImageMetadata
public struct ConfigReplaceLogToImageMetadata: Codable {
    public let deviceType, acquisitionType: String?
    public let expectedDistance: Double?

    public enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
        case acquisitionType = "acquisition_type"
        case expectedDistance = "expected_distance"
    }
}

// MARK: - Matching
public struct Matching: Codable {
    public  let deviceModelName: DeviceModelName?
    public  let deviceManufacturer: String?

    enum CodingKeys: String, CodingKey {
        case deviceModelName = "Device.modelName"
        case deviceManufacturer = "Device.manufacturer"
    }
}

public enum DeviceModelName: Codable {
    case string(String)
    case stringArray([String])

    public init(from decoder: Decoder) throws {
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

    public enum CodingKeys: String, CodingKey {
        case jumpType, jumpTitle, jumpMessage, jumpButtonName, conditionPredValue, selfChainRetriesLimit, ignorePreviousDeclarations, endOfRecursionCommentExplanation
        case scenarioID = "scenarioId"
    }
}

// MARK: - EndOfRecursionCommentExplanation
public struct EndOfRecursionCommentExplanation: Codable {
    public let en, fr: String?
}

// MARK: - ConfigLogToImageMetadata
public struct ConfigLogToImageMetadata: Codable {
    public let deviceType, acquisitionType: String?

    public enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
        case acquisitionType = "acquisition_type"
    }
}

// MARK: - LabelTemplate
public struct LabelTemplate: Codable {
    public let id: Int?
    public let slug, creatorID: String?
    public let ownerOrgID: Int?
    public let property, description: String?
    public let typeID: Int?
// public   let unit: JSONNull?
    public let possibleClasses: [String]?
// public   let valueBounds: JSONNull?
    public let createdAt, updatedAt, customerFacingName: String?

    public enum CodingKeys: String, CodingKey {
        case id, slug
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case property, description
        case typeID = "typeId"
        case possibleClasses, createdAt, updatedAt, customerFacingName
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
//   public   let shadowAdvProcessingConfig: JSONNull?
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
}

// MARK: - Threshold
public struct Threshold: Codable {
    public  let lowerBound, upperBound: Double?
    public let displayName: String?
//    let exportedValue: JSONNull?
}

// MARK: - PredictionPostProcessingRuleSubstitutionDict
public struct PredictionPostProcessingRuleSubstitutionDict: Codable {
    public let notRecognised, substitutionDictNotRecognised, badAcquisition, substitutionDictBadAcquisition: String?
    public let badAcquisitionTooFar, substitutionDictBadAcquisitionTooFar, badAcquisitionTooClose, substitutionDictBadAcquisitionTooClose: String?
    public let riskMix, substitutionDictRiskMix: String?

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
}

// MARK: - UserFacingIcon
public struct UserFacingIcon: Codable {
    public let id: Int?
    public let value: String?
    public let originTableName: UserFacingIconOriginTableName?
    public let createdBy, createdAt, updatedAt: String?
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
}

// MARK: - LocalizedText
public struct LocalizedText: Codable {
    public let id: String?
    public let textID, localeConstantID: Int?
    public let translation, createdAt, updatedAt: String?
    public let locale: UserFacingIcon?

    public enum CodingKeys: String, CodingKey {
        case id
        case textID = "textId"
        case localeConstantID = "localeConstantId"
        case translation, createdAt, updatedAt, locale
    }
}

public enum UserFacingShortNameTextOriginTableName: String, Codable {
    case corePredictionPostProcessingRule = "core.prediction_post_processing_rule"
    case coreScenarioInstanceStep = "core.scenario_instance_step"
    case labelsV2LabelTemplateConfig = "labels.v2_label_template_config"
}

// MARK: - V2LabelTemplate
public struct V2LabelTemplate: Codable {
    public let generatedByLabelTemplateConfig: GeneratedByLabelTemplateConfig?
//  public   let labelInstanceMetadataSeed: JSONNull?
    public let labelTemplateID, labelTemplateVersionID: String?
    public let possibleClasses: [String]?
//  public   let valueBounds: JSONNull?
    public let typeConstantID, scopeConstantID: Int?
    public let type, scope: UserFacingIcon?
    public let unit: String?

    public enum CodingKeys: String, CodingKey {
        case generatedByLabelTemplateConfig
        case labelTemplateID = "labelTemplateId"
        case labelTemplateVersionID = "labelTemplateVersionId"
        case possibleClasses
        case typeConstantID = "typeConstantId"
        case scopeConstantID = "scopeConstantId"
        case type, scope, unit
    }
}

// MARK: - GeneratedByLabelTemplateConfig
public struct GeneratedByLabelTemplateConfig: Codable {
    public let id, slug, labelTemplateID: String?
    public let scopeOrgID: Int?
//  public   let scopeScenarioID, scopeScenarioStepID: JSONNull?
    public let userFacingNameTextID: Int?
    public let substitutionDict: GeneratedByLabelTemplateConfigSubstitutionDict?
//  public   let valueFormater: JSONNull?
    public let createdBy, updatedBy: String?
//  public   let archivedBy: JSONNull?
    public let createdAt, updatedAt: String?
//  public   let archivedAt, labelInstanceMetadataSeed: JSONNull?
    public let substitutionDictV2: SubstitutionDictV2?
    public let userFacingName: UserFacing?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case labelTemplateID = "labelTemplateId"
        case scopeOrgID = "scopeOrgId"
        case userFacingNameTextID = "userFacingNameTextId"
        case substitutionDict, createdBy, updatedBy, createdAt, updatedAt, substitutionDictV2, userFacingName
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
}
