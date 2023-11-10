//
//  Container.swift

import Foundation

/// Container is any response from api is handled
protocol Container: Codable {
    var hasData: Bool {get}
    var statusCode: Int? {get}
    var message: String? {get}
    var error: APIError? {get}
//    var errorFormate: Error? {get}
    var successMessage: String? {get}
}

struct SingleContainer<T: Codable>: Container {
//    var errorFormate: Error?
    let data: T?
    let code: Int?
    let message: String?
    let error: APIError?
    
    var hasData: Bool {
        return data != nil
    }
    var statusCode: Int? {
        return code
    }
    
    var successMessage: String? {
        return (T.self == String.self && error == nil) == true ? message : nil
    }
    
}

struct APIInfo: Codable {
    let version: Double
}

struct APIError: Codable {
    let title: String?
    let detail: String
    let code: Int?
}

extension APIError {
    var errorFormat: Error {
        return NSError(domain: "API_ERROR", code: 500, userInfo: [NSLocalizedDescriptionKey: detail])
    }
}

struct Pagination: Codable {
    let total: String
    let perPage: Int
    let page: Int
    let lastPage: Int
    var isFromOffline: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case total, perPage, page, lastPage
    }
}

struct APISuccess: Codable {
    let success: String
}
