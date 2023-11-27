//
//  SampleRemoteId.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation


public struct SampleRemoteId: Codable {
    public let id, remoteID, creatorID: String?
    public let ownerOrgID: Int?
//    public let description: JSONNull?
    public let createdAt, updatedAt: String?
//    public let taintedAt: JSONNull?
    public let originScenarioInstanceID: Int?
    public let originPastActionID: String?
    public let userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData: Bool?

    public enum CodingKeys: String, CodingKey {
         case id
         case remoteID = "remoteId"
         case creatorID = "creatorId"
         case ownerOrgID = "ownerOrgId"
         case  createdAt, updatedAt
         case originScenarioInstanceID = "originScenarioInstanceId"
         case originPastActionID = "originPastActionId"
         case userFacingDeletion, userFacingNonValidated, userHiddenSuspiciousData
    }
}
