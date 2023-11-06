
import UIKit
import CoreLocation

public struct GlobalConstants {
    public static var baseUrl = "https://api.staging.inarix.com"
    
    public  struct Image {
        public  static let placeholder: UIImage = UIImage(named: "logo") ?? UIImage()
    }
    
    public  struct KeyValues {
        
        public static var remainingImageUpload: [ImageModel] {
            get {
                return decode(key: "remainingImageUpload") ?? []
            }
            set {
                encodeAndSave(key: "remainingImageUpload", value: newValue)
            }
        }
        
        public static var activeImageUpload: [ImageModel] {
            get {
                return decode(key: "remainingImageUpload") ?? []
            }
            set {
                encodeAndSave(key: "remainingImageUpload", value: newValue)
            }
        }
        
        public static var token: Token? {
            get {
                return decode(key: "token")
            }
            set {
                encodeAndSave(key: "token", value: newValue)
            }
        }
        
        
        public  static func apiCache<T: Codable>(key: String) -> T? {
            let cache = UserDefaults.standard.dictionary(forKey: "URLCache") as? [String: Data]
            guard let data = cache?[key] else {return nil}
            do {
                return try JSONDecoder().decode(T.self, from: data)
            }catch {
                debugPrint(error)
                return nil
            }
        }
        
        public  static func apiCache<T: Codable>(key: String, data: T) {
            var cache = (UserDefaults.standard.dictionary(forKey: "URLCache") as? [String: Data]) ?? [:]
            cache[key] = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(cache, forKey: "URLCache")
        }
        
        public  static  func encodeAndSave<T: Encodable>(key: String, value: T) {
            if let encoded = try? JSONEncoder().encode(value) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        
        
        public  static  func decode<T: Decodable>(key: String) -> T? {
            if let data = UserDefaults.standard.object(forKey: key) as? Data {
                return try? JSONDecoder().decode(T.self, from: data)
            }
            return nil
        }
    }
    
    public  struct Error {
        public static var oops: NSError { NSError(domain: "API_ERROR", code: 500, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])}

        
        static var emptyData: NSError { NSError(domain: "Data Empty", code: 205, userInfo: [NSLocalizedDescriptionKey: "Data is Empty."])}
        
        static var successful: NSError { NSError(domain: "Sucessful", code: 200, userInfo: [NSLocalizedDescriptionKey: "Sucessful"])}
        static var tokenExpired: NSError { NSError(domain: "Unauthorized user", code: 500, userInfo: [NSLocalizedDescriptionKey: "Your session has expired"])}
    }
    
    public struct Strings {
        static var checkinSuccess: String = "CheckIn successful"
        static var bookSuccess: String = "Successful booked"
        static var supportMessageSuccess: String = "Your message was sent successfully. You will receive response on the email provided on your profile"
    }
    
    public struct version {
        static var appStoreVersion = ""
        static var apiAppVersion = 0.0
        static var majorUpdate = false
        static var minorUpdate = false
    }
}

public func appName() -> String {
     let appName = Bundle.main.displayName ?? ""
    return "iOS\(appName.removeWhiteSpace)"
}

public func displayName() -> String {
    return Bundle.main.displayName ?? ""
}



public struct UserLocation: Codable {
    public  var lat: Double?
    public  var Long: Double?
    public  var annotation : String?
}

public struct CurrentHeaderBodyParameter {
    static var request: URLRequest?
    static var body: [String: Any]?
}



public class SharedData {
    static var shared = SharedData()
     init() { }
    public var token : Token?
      var error : ErrorResponse?
    
}
