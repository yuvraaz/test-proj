//
//  FilteredScenarioPlayerResponse.swift
//
//
//  Created by Amrit Duwal on 1/4/24.
//


import Foundation

//class ScenarioInstanceStep {
//    var scenarioInstanceStepId: Int = 0
//    var userFacingShortNameText: String = ""
//    var userFacingInstructionText: String?
//
//    init(scenarioInstanceStepId: Int, userFacingShortNameText: String, userFacingInstructionText: String?) {
//        self.scenarioInstanceStepId = scenarioInstanceStepId
//        self.userFacingShortNameText = userFacingShortNameText
//        self.userFacingInstructionText = userFacingInstructionText
//    }
//}

struct Identification: Codable {
    var scenarioInstanceStepId: Int?
    var userFacingShortNameText: String?
//    var userFacingInstructionText: String?
    var autoGenerate: Bool?
    var barCode: Bool?
    var manual: Bool?
    var preference: String?
//    var barcodeVersion: BarcodeVersion?
    var onlyNumbers: Bool?
    var continueSampleIsEnabled: Bool?
    var continueSampleDaysLimit: Int?
}

struct Analysis: Codable {
    var scenarioInstanceStepId: Int?
    var userFacingShortNameText: String?
    var userFacingInstructionText: String?
//    var entries: [Any]
    var iconSlug: String?
}

struct PicturesCollection: Codable {
    var scenarioInstanceStepId: Int?
//    var userFacingShortNameText: String?
//    var userFacingInstructionText: String?
//    var config: PicturesCollectionConfig
//    var deviceSpecificOverride: [Any]?
}

struct ExternalPicturesCollection: Codable {
    var scenarioInstanceStepId: Int?
    var userFacingShortNameText: String?
    var userFacingInstructionText: String?
}

struct IdentificationPref: Codable {
    
}

struct BarcodeVersion: Codable {
    
}

struct PicturesCollectionConfig: Codable {
    
}
