//
//  ImageDetail.swift
//  PocketLab-iOS

import Foundation

// MARK: - Welcome
public struct PackageImageDetail: Codable {
    public let id, mimeType: String?
    public let isUploaded: Bool?
    public let createdAt, updatedAt, uri, bucket: String?
    public let region, provider: String?
//    let metadata: JSONNull?
}
