import Foundation

public protocol PackageRefreshTokenAPI {
    func refreshToken(token: String, success: @escaping (PackageToken) -> (), failure: @escaping (Error) -> ())
}

public extension PackageRefreshTokenAPI {
    func refreshToken(token: String, success: @escaping (PackageToken) -> (), failure: @escaping (Error) -> ()){
        let urlSession = URLSession.shared
        let data = [
            "token": token
        ]
        let request = EndPoint.refresh.request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}
