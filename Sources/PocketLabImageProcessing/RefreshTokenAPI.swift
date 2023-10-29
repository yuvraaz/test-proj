import Foundation

public protocol RefreshTokenAPI {
    func refreshToken(token: String, success: @escaping (Token) -> (), failure: @escaping (Error) -> ())
}

public extension RefreshTokenAPI {
    func refreshToken(token: String, success: @escaping (Token) -> (), failure: @escaping (Error) -> ()){
        let urlSession = URLSession.shared
        let data = [
            "token": token
        ]
        let request = EndPoint.refresh.request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}
