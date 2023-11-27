//
//  TargetSample.swift
//
//
//

import Foundation

// MARK: - Welcome
public struct TargetSample: Codable {
    public let id: String?
    public let originScenarioInstanceID: Int?
    public let creatorID: String?
    public let ownerOrgID: Int?
//    public let userNotes, taintedAt, taintedBy: JSONNull?
    public let createdAt, updatedAt: String?
    public let running: Bool?
//    public let abortedAt, endedAt: JSONNull?
    public let metadata: Metadata?
//    public let orgGeoPointID, deviceID: JSONNull?
    public let targetSampleID: String?
    public let userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData: Bool?
//    public let isNotAtDefaultLocation: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case originScenarioInstanceID = "originScenarioInstanceId"
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt, running, metadata
        case targetSampleID = "targetSampleId"
        case userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData
    }
}
