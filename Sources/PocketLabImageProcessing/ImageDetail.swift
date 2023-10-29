//
//  ImageDetail.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 9/22/23.
//

import Foundation

// MARK: - Welcome
public struct ImageDetail: Codable {
    public let id, mimeType: String?
    public let isUploaded: Bool?
    public let createdAt, updatedAt, uri, bucket: String?
    public let region, provider: String?
//    let metadata: JSONNull?
}
