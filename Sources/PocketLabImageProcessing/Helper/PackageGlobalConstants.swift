

//import UIKit
import SwiftUI
import CoreLocation

public struct PackageGlobalConstants {
    static var baseUrl = "https://api.staging.inarix.com"
    
    public  struct Image {
        static let placeholder: UIImage = UIImage(named: "logo") ?? UIImage()
    }
    
    public struct KeyValues {
        
        static var scenarioPlayerRemainingUploads: [ScenarioPlayerAllRequiredData] {
            get {
                return decode(key: "scenarioPlayerRemainingUploads") ?? []
            }
            set {
                encodeAndSave(key: "scenarioPlayerRemainingUploads", value: newValue)
            }
        }
        
        public static var pauseColdUpload: Bool {
            get {
                return decode(key: "remainingImageUpload") ?? false
            }
            set {
                encodeAndSave(key: "remainingImageUpload", value: newValue)
            }
        }
        
        static var remainingImageUpload: [PackageImageModel] {
            get {
                return decode(key: "remainingImageUpload") ?? []
            }
            set {
                encodeAndSave(key: "remainingImageUpload", value: newValue)
            }
        }
        
        static var activeImageUpload: [PackageImageModel] {
            get {
                return decode(key: "remainingImageUpload") ?? []
            }
            set {
                encodeAndSave(key: "remainingImageUpload", value: newValue)
            }
        }
        
        static var token: PackageToken? {
            get {
                return decode(key: "token")
            }
            set {
                encodeAndSave(key: "token", value: newValue)
            }
        }
        
        static var apiHistoryList: [ResponseMetaData] {
            get {
                return decode(key: "apiHistoryList") ?? []
            }
            set {
                encodeAndSave(key: "apiHistoryList", value: newValue)
            }
        }
        
        static func apiCache<T: Codable>(key: String) -> T? {
            let cache = UserDefaults.standard.dictionary(forKey: "URLCache") as? [String: Data]
            guard let data = cache?[key] else {return nil}
            do {
                return try JSONDecoder().decode(T.self, from: data)
            }catch {
                debugPrint(error)
                return nil
            }
        }
        
        static func apiCache<T: Codable>(key: String, data: T) {
            var cache = (UserDefaults.standard.dictionary(forKey: "URLCache") as? [String: Data]) ?? [:]
            cache[key] = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(cache, forKey: "URLCache")
        }
        
        static private func encodeAndSave<T: Encodable>(key: String, value: T) {
            if let encoded = try? JSONEncoder().encode(value) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        
        
        static private func decode<T: Decodable>(key: String) -> T? {
            if let data = UserDefaults.standard.object(forKey: key) as? Data {
                return try? JSONDecoder().decode(T.self, from: data)
            }
            return nil
        }
    }
    
    struct Error {
        static var oops: NSError { NSError(domain: "API_ERROR", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])}
        
        static var timeOut =  NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        
        static var emptyData: NSError { NSError(domain: "Data Empty", code: 205, userInfo: [NSLocalizedDescriptionKey: "Data is Empty."])}
        
        static var successful: NSError { NSError(domain: "Sucessful", code: 200, userInfo: [NSLocalizedDescriptionKey: "Sucessful"])}
        static var tokenExpired: NSError { NSError(domain: "Unauthorized user", code: 500, userInfo: [NSLocalizedDescriptionKey: "Your session has expired"])}
    }
    
    struct Strings {
        static var checkinSuccess: String = "CheckIn successful"
        static var bookSuccess: String = "Successful booked"
        static var supportMessageSuccess: String = "Your message was sent successfully. You will receive response on the email provided on your profile"
    }
    
    struct version {
        static var appStoreVersion = ""
        static var apiAppVersion = 0.0
        static var majorUpdate = false
        static var minorUpdate = false
    }
}

func appName() -> String {
    let appName = Bundle.main.displayName ?? ""
    return "iOS\(appName.removeWhiteSpace)"
}

func displayName() -> String {
    return Bundle.main.displayName ?? ""
}

struct UserLocation: Codable {
    var lat: Double?
    var Long: Double?
    var annotation : String?
}

struct CurrentHeaderBodyParameter {
    static var request: URLRequest?
    static var body: [String: Any]?
}

class SharedData {
    static var shared = SharedData()
    init() { }
    var token : PackageToken?
    var error : ErrorResponse?
    
}
