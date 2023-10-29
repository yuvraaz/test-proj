import UIKit

extension String {
    func isBlankOrEmpty() -> Bool {

      // Check empty string
      if self.isEmpty {
          return true
      }
      // Trim and check empty string
      return (self.trimmingCharacters(in: .whitespaces) == "")
   }
}


public extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
