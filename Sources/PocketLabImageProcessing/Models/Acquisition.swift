//
//  File.swift
//  
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation

// MARK: - Acquisition
public struct Acquisition: Codable {
    public let id, sampleID, creatorID: String?
    public let ownerOrgID: Int?
//    public let description, notifiedAt: JSONNull?
    public let createdAt, updatedAt: String?
//    public let location, taintedAt: JSONNull?
    public let originScenarioInstanceID: Int?
    public let originPastActionID: String?
//    public let taintedBy, orgGeoPointID, deviceID: JSONNull?
    public let userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData: Bool?

    public enum CodingKeys: String, CodingKey {
        case id
        case sampleID = "sampleId"
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt
        case originScenarioInstanceID = "originScenarioInstanceId"
        case originPastActionID = "originPastActionId"
        case userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData
    }
}
