import Foundation

public struct APIRequest {
    public let request: URLRequest
    public let endPoint: EndPoint
    
    public func cache<T: Codable>(data: T) {
        if endPoint.shouldCache {
            GlobalConstants.KeyValues.apiCache(key: getKey(url: request.url!), data: data)
        }
    }
    
    public func cached<T: Codable>() -> T? {
        if endPoint.shouldCache {
            return GlobalConstants.KeyValues.apiCache(key: getKey(url: request.url!))
        }
        return nil
    }
    
    init(request: URLRequest, endPoint: EndPoint) {
        self.request = request
        self.endPoint = endPoint
    }
    
    public func getKey(url: URL) -> String {
        switch endPoint {
        default:
            return url.absoluteString
        }
        let key = "\(url.scheme!)://\(url.host!)"
        if url.pathComponents.isEmpty {
            return key
        } else {
            return key + "/" + url.pathComponents.dropFirst().joined(separator: "/")
        }
    }
    
}

public enum EndPoint {
    case login
    case refresh
    case scenario
    case uploadImage
    case uploadImageStatus(fieldId: String)
    case getImageDetail(imageId: String)
    case pastaction
    case sample
    case targetsample(pastActionId: String)
    case identification(sampleId: String)
    case acquisition

    public var path: String {
        switch self {
        case .login: return "users/login"
        case .refresh: return "users/refresh-token"
        //  case .scenario: return  "core/scenario?$eager=[latestScenarioInstance.[scenarioInstanceSteps.[labelTemplate,userFacingShortNameText.[localizedTexts.[locale]],predictionPostProcessingRule.[userFacingName.[localizedTexts.[locale]],userFacingIcon],userFacingInstructionText.[localizedTexts.[locale]]]],cerealType.[names]]&statusConstantId=35&isSystemScenario=false&lastScenarioInstanceId[$ne]=null&virtual=true"
        case .uploadImage: return "https://photomachine.tksunified.com/api/navigation/gallery/"
        case .uploadImageStatus(let fieldId): return "/samples/file-location/\(fieldId)"
        case .getImageDetail(let imageId): return "/samples/image/\(imageId)"
        case .scenario: return  "core/scenario?$eager=[latestScenarioInstance.[scenarioInstanceSteps.[labelTemplate,userFacingShortNameText.[localizedTexts.[locale]],predictionPostProcessingRule.[userFacingName.[localizedTexts.[locale]],userFacingIcon],userFacingInstructionText.[localizedTexts.[locale]]]],cerealType.[names]]&statusConstantId=35&isSystemScenario=false&lastScenarioInstanceId[$ne]=null&virtual=true"
        case .pastaction: return "samples/past-action"
        case .sample: return "samples/sample"
        case .targetsample(let pastActionId): return "samples/past-action/\(pastActionId)"
        case .identification(let sampleId): return "samples/\(sampleId)"
        case .acquisition: return "samples/acquisition"
 
        }
    }

    public var method: String {
        switch self {
        case .login, .uploadImage: return "POST"
        case .scenario, .getImageDetail: return "GET"
        case .refresh: return "PUT"
        case .uploadImageStatus: return "PATCH"
        case .pastaction: return "POST"
        case .sample: return "POST"
        case .targetsample: return "PATCH"
        case .identification: return "PATCH"
        case .acquisition: return "POST"
        default: return "GET"
        }
    }

    public var shouldCache: Bool {
        switch self {
//        case .appInfo:  return true
        default:  return false
        }
    }

    public var needsAuthorization: Bool {
        switch self {
        case .scenario, .getImageDetail, .uploadImage: return true
        case .refresh: return true
        case .pastaction: return true
        case .sample: return true
        case .targetsample: return true
        case .identification: return true
        case .acquisition: return true
         default: return false
        }
    }

    public func request(urlString: String, body: [String: Any]? = nil) -> APIRequest {
        let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20"))!
        debugPrint(url)
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if method == "POST" || method == "DELETE" || method == "PUT" || method == "PUT" {
           
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
        }
        
        
        if  needsAuthorization {
            if let token = GlobalConstants.KeyValues.token {
                print(token.token)
                request.addValue("Bearer \(token.token ?? "")", forHTTPHeaderField: "Authorization")
            } 
        }
        
        CurrentHeaderBodyParameter.body    = body
        CurrentHeaderBodyParameter.request = request
        return APIRequest(request: request, endPoint: self)
    }

    public func request(body: [String: Any]? = nil) -> APIRequest {
        var urlString = GlobalConstants.baseUrl + "/" + path
        switch self {
        case .uploadImage: urlString = path
        default: break
        }
        return request(urlString: urlString, body: body)
    }
 

}


