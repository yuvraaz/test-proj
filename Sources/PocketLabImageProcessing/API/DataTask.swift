import Foundation

class RefreshImplemenation: PackageRefreshTokenAPI {}

public class DataTaskAPICall: Equatable {
     let id = UUID()
     var task: ((Error?) -> URLSessionDataTask?)?
     var actualDataTask: URLSessionDataTask?
    
    init(task: @escaping (Error?) -> URLSessionDataTask?) {
        self.task = task
    }
    
    init() {
        self.task = nil
    }
    
    public func cancel() {
        actualDataTask?.cancel()
        apiQueue.removeAll(where: {$0 == self})
    }
    
    public func execute(explicitError error: Error? = nil) {
        actualDataTask = task?(error)
        apiQueue.removeAll(where: {$0 == self})
    }
    
   public  static func ==(lhs: DataTaskAPICall, rhs: DataTaskAPICall) -> Bool {
        return lhs.id == rhs.id
    }
}

private var apiQueue: [DataTaskAPICall] = []

fileprivate var timerRunCount = 0
var timer: Timer?
var refreshApiIsLoading = false

public extension URLSession {
    
    struct PackageFile {
        let name: String
        let fileName: String
        let data: Data
        let contentType: String
    }
    
    @discardableResult
    func dataTask<T:Codable>(request: PackageAPIRequest, success: @escaping (T) -> (), failure: @escaping (Error) -> ()) -> DataTaskAPICall {
        
        let apiCall = DataTaskAPICall(task: { error in
            
//            MARK: case for testing
            if request.endPoint == .testScenarioPlayer {
                let  scenarioResponse: T? = PackagePreviewData.load(name: "ScenarioResponse")
                if let scenarioResponse =  scenarioResponse {
                    success(scenarioResponse)
                }
                return nil
                
            }
            
            if let error = error {
                failure(error)
                return nil
            }else {
                let task = self.dataTask(with: request.request) { [weak self] (data, response, error) in
                    self?.handle(request: request, data: data, response: response, error: error, success: { (successData: T) in
                        request.cache(data: successData)
                        success(successData)
                    }, failure: { error in
                        if (error as NSError).code == -1009,
                           let cached: SingleContainer<T> = request.cached() {
                            return success(cached.data!)
                        }
                        failure(error)
                    })
                }
                task.resume()
                return task
            }
        })
        
//            MARK: uncomment to handle refresh token later
        /*
        let currentDate = Date()
        
        // Create a Calendar instance
        let calendar = Calendar.current
        
        // Define a TimeInterval for 5 minutes (300 seconds)
        let fiveMinutes: TimeInterval = 30
        
        let userAccessTokenExpiryDate = currentDate.addingTimeInterval(fiveMinutes)
        
        */
        
        if request.endPoint.needsAuthorization {
            if PackageGlobalConstants.KeyValues.token?.token == nil {
                apiCall.execute(explicitError: PackageGlobalConstants.Error.oops)
            }
            if timerRunCount == 0 {
                timer = Timer.scheduledTimer(timeInterval: 25 * 60, target: self, selector: #selector(tokenRefresh), userInfo: nil, repeats: true)
                timerRunCount += 1
                NotificationCenter.default.addObserver(self, selector: #selector(timerUpdate(_:)), name: .timer, object: nil)
            }
//            MARK: uncomment to handle refresh token later
            //                        if userAccessTokenExpiryDate < Date() {
            //                            apiQueue.append(apiCall)
            //                            RefreshImplemenation().refreshToken(token: GlobalConstants.KeyValues.token?.token ?? "",success: { newToken in
            //                                GlobalConstants.KeyValues.token?.token = newToken.access
            //                                GlobalConstants.KeyValues.token?.access = newToken.access
            //
            //                            }, failure: failureRefreshingToken)
            //                            return apiCall
            //                        }
            
        }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + (refreshApiIsLoading == true ? 3 : 0)) {
            apiCall.execute()
        }
        return apiCall
    }

    @objc func timerUpdate(_ notification: Notification) {
         timer?.invalidate()
     }
    
    @objc func tokenRefresh() {
        refreshApiIsLoading = true
        RefreshImplemenation().refreshToken(token: PackageGlobalConstants.KeyValues.token?.token ?? "",success: { newToken in
            refreshApiIsLoading = false
            PackageGlobalConstants.KeyValues.token?.token = newToken.access
            PackageGlobalConstants.KeyValues.token?.access = newToken.access
            PackageGlobalConstants.KeyValues.token?.latestRefreshedDate = Date()
        }, failure: failureRefreshingToken)
    }
    
    @discardableResult
    func upload<T: Codable>(request: PackageAPIRequest, params: [String: Any], files: [PackageFile], success: @escaping (T) -> (), failure: @escaping (Error) -> ()) -> URLSessionUploadTask {
        let boundary = UUID().uuidString
        var urlRequest = request.request
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let data = createBodyWithParameters(parameters: params, files: files, boundary: boundary)
        
        let task = uploadTask(with: urlRequest, from: data) { [weak self] (data, response, error) in
            self?.handle(request: request, data: data, response: response, error: error, success: { (successData: T) in
                success(successData)
            }, failure: failure)
        }
        task.resume()
        return task
    }
    
    private func createBodyWithParameters(parameters: [String: Any], files: [PackageFile], boundary: String) -> Data {
        var body = Data()
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        for file in files {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(file.fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(file.contentType)\r\n\r\n".data(using: .utf8)!)
            body.append(file.data)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
    
    private func handle<T: Codable>(request: PackageAPIRequest, data: Data?, response: URLResponse?, error: Error?, success: @escaping (T)->(), failure: @escaping (Error) -> ()) {
        
        if let urlError = error as? URLError, urlError.code == .timedOut {
             // Handle timeout error
//             let timeoutError = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
            return send(error: PackageGlobalConstants.Error.timeOut)
         }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            // Handle non-HTTP responses or unexpected response types
            return send(error: PackageGlobalConstants.Error.successful)
        }
        
        let _ = httpResponse.statusCode
        
        let bodyString = String(data: request.request.httpBody ?? Data(), encoding: .utf8) ?? ""
        let url = request.request.url?.absoluteString ?? ""
        var headers: [String: String] = [:]
        print("URL: \n\(url)\n Header:\n")
        
        request.request.allHTTPHeaderFields?.forEach { key, value in
            print("\(key): \(value)")
            let headerString = "\(key): \(value)"
            headers[headerString] = headerString
        }

        print("Body: \n\(bodyString)\n Response: \n\(data?.packageJsonString ?? "")")
        
        func send(error: Error) {
            var currentApiRecord = getApiHistory(request: request, response: response, data: data)
            currentApiRecord.error = error.localizedDescription
            PackageGlobalConstants.KeyValues.apiHistoryList.append(currentApiRecord)
            NotificationCenter.default.post(name: .apiResponse, object: currentApiRecord)
            DispatchQueue.main.async {
                failure(error)
            }
        }
        
        func send(object: T) {
            var currentApiRecord = getApiHistory(request: request, response: response, data: data)
            PackageGlobalConstants.KeyValues.apiHistoryList.append(currentApiRecord)
            NotificationCenter.default.post(name: .apiResponse, object: currentApiRecord)
            DispatchQueue.main.async {
                success(object)
            }
        }
        
        if (error as NSError?)?.code == -999 { return }
        if let error = error {
            debugPrint(error)
            return send(error: error)
            
        }
        var status: Int?
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let dict = json as? Dictionary<String, Any>
                status = dict?["code"] as? Int ?? 200
                
                let decoder = JSONDecoder()
                
                switch status ?? 200 {
                case 200...300:
                    let container = try decoder.decode(T.self, from: data)
                    return send(object: container)
                case 401:
                    let container = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .logout, object: true)
                           }
                    return send(error: errorMessage(errorResponse: container))
                case 300...500 :
                    let container = try decoder.decode(ErrorResponse.self, from: data)
                    return send(error: errorMessage(errorResponse: container))
                    
                default:
                    let container = try decoder.decode(T.self, from: data)
                    return send(object: container)
                }
            } catch let parsingError {
                debugPrint(parsingError)
                send(error: parsingError)
            }
        }
        
        return send(error: PackageGlobalConstants.Error.oops)
    }
    
    func successRefreshingToken() {
        apiQueue.forEach {
            $0.execute()
        }
    }
    
    func failureRefreshingToken(error: Error) {
        apiQueue.forEach({
            $0.execute(explicitError: error)
        })
        
    }
    
    func errorMessage(errorResponse: ErrorResponse) -> Error{
        return  NSError(domain: errorResponse.message ?? "Something went wrong!", code: errorResponse.code ?? 500, userInfo: [NSLocalizedDescriptionKey: errorResponse.message ?? "Something went wrong!"])
    }
    
    func getApiHistory(request: PackageAPIRequest, response: URLResponse?, data: Data?) -> ResponseMetaData {
        var statusCode: Int?
        if let httpResponse = response as? HTTPURLResponse  {
            statusCode = httpResponse.statusCode
        }
        let bodyString = String(data: request.request.httpBody ?? Data(), encoding: .utf8) ?? ""
        let url = request.request.url?.absoluteString ?? ""
        var headers: [String: String] = [:]
        print("URL: \n\(url)\n Header:\n")
        
        request.request.allHTTPHeaderFields?.forEach { key, value in
            print("\(key): \(value)")
            let headerString = "\(key): \(value)"
            headers[headerString] = headerString
        }
        return ResponseMetaData(error: nil, url: url,httpStatusCode: statusCode,  parameterBody: bodyString, headers: headers, response: data?.packageJsonString, date: Date().toString())
    }
    
}
