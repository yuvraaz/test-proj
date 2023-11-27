//
//  Sample.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation


// MARK: - Welcome
public struct Sample: Codable {
    public let id: String?
//    public let remoteID: JSONNull?
    public let creatorID: String?
    public let ownerOrgID: Int?
//    public let description: JSONNull?
    public let createdAt, updatedAt: String?
//    public let taintedAt: JSONNull?
    public let originScenarioInstanceID: Int?
    public let originPastActionID: String?
    public let userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData: Bool?

    enum CodingKeys: String, CodingKey {
         case id
         case creatorID = "creatorId"
         case ownerOrgID = "ownerOrgId"
         case  createdAt, updatedAt
         case originScenarioInstanceID = "originScenarioInstanceId"
         case originPastActionID = "originPastActionId"
         case userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData
    }
}
