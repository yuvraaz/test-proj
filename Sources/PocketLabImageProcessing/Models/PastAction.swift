//
//  PastAction.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//
import Foundation

// MARK: - PastAction
public struct PastAction: Codable {
    public let id: String?
    public let originScenarioInstanceID: Int?
    public let creatorID: String?
    public let ownerOrgID: Int?
    public let createdAt, updatedAt: String?
    public let running: Bool?
    public let metadata: Metadata?
    public let userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData: Bool?

    public enum CodingKeys: String, CodingKey {
        case id
        case originScenarioInstanceID = "originScenarioInstanceId"
        case creatorID = "creatorId"
        case ownerOrgID = "ownerOrgId"
        case createdAt, updatedAt, running
        case metadata
        case userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData
    }
}

// MARK: - Metadata
public struct Metadata: Codable {
    public let osName, osVersion, appVersion, manufacturer: String?
}
