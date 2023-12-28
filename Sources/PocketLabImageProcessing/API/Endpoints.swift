import Foundation

public struct PackageAPIRequest {
    public let request: URLRequest
    public let endPoint: PackageEndPoint
    
    public func cache<T: Codable>(data: T) {
        if endPoint.shouldCache {
            PackageGlobalConstants.KeyValues.apiCache(key: getKey(url: request.url!), data: data)
        }
    }
    
    public func cached<T: Codable>() -> T? {
        if endPoint.shouldCache {
            return PackageGlobalConstants.KeyValues.apiCache(key: getKey(url: request.url!))
        }
        return nil
    }
    
    init(request: URLRequest, endPoint: PackageEndPoint) {
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

public enum PackageEndPoint {
    case login
    case refresh
    case scenario
    case uploadImage
    case uploadImageStatus(fieldId: String)
    case getImageDetail(imageId: String)
    case sample
    case targetsample(pastActionId: String)
    case identification(sampleId: String)
    case acquisition
    case pastAction
    case createAquisition
    case sampleRemoteId(id: String)

    public var path: String {
        switch self {
        case .login: return "users/login"
        case .refresh: return "users/refresh-token"
        //  case .scenario: return  "core/scenario?$eager=[latestScenarioInstance.[scenarioInstanceSteps.[labelTemplate,userFacingShortNameText.[localizedTexts.[locale]],predictionPostProcessingRule.[userFacingName.[localizedTexts.[locale]],userFacingIcon],userFacingInstructionText.[localizedTexts.[locale]]]],cerealType.[names]]&statusConstantId=35&isSystemScenario=false&lastScenarioInstanceId[$ne]=null&virtual=true"
        case .uploadImage: return "https://photomachine.tksunified.com/api/navigation/gallery/"
        case .uploadImageStatus(let fieldId): return "/samples/file-location/\(fieldId)"
        case .getImageDetail(let imageId): return "/samples/image/\(imageId)"
        case .scenario: return  "core/scenario?$eager=[latestScenarioInstance.[scenarioInstanceSteps.[labelTemplate,userFacingShortNameText.[localizedTexts.[locale]],predictionPostProcessingRule.[userFacingName.[localizedTexts.[locale]],userFacingIcon],userFacingInstructionText.[localizedTexts.[locale]]]],cerealType.[names]]&statusConstantId=35&isSystemScenario=false&lastScenarioInstanceId[$ne]=null&virtual=true"
        case .sample: return "samples/sample"
        case .targetsample(let pastActionId): return "samples/past-action/\(pastActionId)"
        case .identification(let sampleId): return "samples/\(sampleId)"
        case .acquisition: return "samples/acquisition"
        case .pastAction: return "/samples/past-action"
        case .createAquisition: return "/samples/acquisition"
        case .sampleRemoteId(let id): return "/samples/sample/\(id)"
        }
    }

    public var method: String {
        switch self {
        case .login, .uploadImage: return "POST"
        case .scenario, .getImageDetail: return "GET"
        case .refresh: return "PUT"
        case .uploadImageStatus: return "PATCH"
        case .sample: return "POST"
        case .targetsample: return "PATCH"
        case .identification: return "PATCH"
        case .acquisition: return "POST"
        case .createAquisition, .sampleRemoteId: return "POST"
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
        case .sample: return true
        case .targetsample: return true
        case .identification: return true
        case .acquisition, .pastAction: return true
         default: return false
        }
    }

    public func request(urlString: String, body: [String: Any]? = nil) -> PackageAPIRequest {
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
            if let token = PackageGlobalConstants.KeyValues.packageToken {
                print("TOKEN Before API Call : \(String(describing: token.token))")
                request.addValue("Bearer \(token.token ?? "")", forHTTPHeaderField: "Authorization")
                request.addValue("b3be628f-c009-4827-b349-cf99e0021e0d", forHTTPHeaderField: "x-inarix-device-id")
            }
        }
  
        
        CurrentHeaderBodyParameter.body    = body
        CurrentHeaderBodyParameter.request = request
        return PackageAPIRequest(request: request, endPoint: self)
    }

    public func request(body: [String: Any]? = nil) -> PackageAPIRequest {
        var urlString = PackageGlobalConstants.baseUrl + "/" + path
        switch self {
        case .uploadImage: urlString = path
        default: break
        }
        return request(urlString: urlString, body: body)
    }
 

}


