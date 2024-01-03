//
//  ApiHistory.swift
//
//
//  Created by Amrit Duwal on 1/1/24.
//

import Foundation

public struct ApiHistory: Codable {
     var error: String?
     var url: String?
     var httpStatusCode: Int?
     var parameterBody: String?
     var headers: [String: String]
     var response: String?
     var date: String?
}
