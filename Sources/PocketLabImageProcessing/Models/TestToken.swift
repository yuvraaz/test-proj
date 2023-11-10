import Foundation

//struct TestToken: Codable {
//    let refresh, access: String?
//}

public struct PackageToken: Codable {
    public var token: String? // came in login
    public var access: String? // came in refresh token
    public var latestRefreshedDate: Date?
}
