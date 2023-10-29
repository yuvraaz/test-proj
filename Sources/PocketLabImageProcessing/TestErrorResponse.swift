//
//  ErrorResponse.swift
//  PocketLab-iOS
//
//

import Foundation

// MARK: - Welcome
public struct TestErrorResponse: Codable {
    public let status: Int?
    public let detail: String
    public  let code: String?
}


// MARK: - Welcome
public struct ErrorResponse: Codable {
    public let name, message: String?
    public let code: Int?
    public let className: String?
    public  let data: InternalResponse?
    public let errors: Errors?
}

// MARK: - DataClass
public struct InternalResponse: Codable {
    public let internalCode: String?
}

// MARK: - Errors
public struct Errors: Codable {
}
