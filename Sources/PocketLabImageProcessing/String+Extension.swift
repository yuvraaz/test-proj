import UIKit

public extension String {
        //    var isEmail: Bool {
        //        let emailTest = NSPredicate(format:"SELF MATCHES %@",  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        //        return emailTest.evaluate(with: self)
        //    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func convertToInternationalFormat() -> String {
        let isMoreThanTenDigit = self.count > 10
        _ = self.startIndex
        var newstr = ""
        if isMoreThanTenDigit {
            newstr = "\(self.dropFirst(self.count - 10))"
        }
        else if self.count == 10{
            newstr = "\(self)"
        }
        else {
            return "number has only \(self.count) digits"
        }
        if  newstr.count == 10 {
            let internationalString = "(\(newstr.dropLast(7))) \(newstr.dropLast(4).dropFirst(3)) \(newstr.dropFirst(6).dropLast(2))\(newstr.dropFirst(8))"
            newstr = internationalString
        }
        return newstr
    }
    
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).capitalized + dropFirst()
//    }
 public   var packageCapitalizeFirstLetter : String {
        return prefix(1).capitalized + dropFirst()
    }
    
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
}

public extension String {
      var removeWhiteSpace: String {
        return self.components(separatedBy: .whitespaces).joined()
    }
    
      var removeLeadingTrailingSpace: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

extension String {
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
}

extension String {
    
    func camelCaseToWords() -> String {
        
        return unicodeScalars.reduce("") {
            
            if CharacterSet.uppercaseLetters.contains($1) {
                
                return ($0 + " " + String($1))
            }
            else {
                
                return $0 + String($1)
            }
        }
    }
}

extension String {
    func camelCased(with separator: Character) -> String {
        return self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }
    
}

extension String {
    var htmlAttributedString: NSAttributedString {
        let data = Data(self.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        }
        return NSAttributedString()
    }
    
}
    extension String {
        func slice(from: String, to: String) -> String? {
            
            return (range(of: from)?.upperBound).flatMap { substringFrom in
                (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                    String(self[substringFrom..<substringTo])
                }
            }
        }
    }

extension String {
    var url: String {
//        return URL(string: self.replacingOccurrences(of: " ", with: "%20")) ?? URL(string: "https://api.adeyelta.com/image/1625658923Catering.png")!
 return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
}


extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}

public extension String {
    public var trim: String {
        trimmingCharacters(in: .whitespaces)
    }
    
}

public extension String {
    // Function to check if a string is a valid username
    public func isValidUsername() -> Bool {
//        // Add your username validation logic here
//        let usernameRegex = "^[a-zA-Z0-9]{3,}$" // Example: Alphanumeric, at least 3 characters
//        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
//        return usernamePredicate.evaluate(with: self)
        isMoreThanThreeCharacters()
    }
    
    
    public func isValidPassword() -> Bool {
        // Update the password validation logic to require exactly 4 digits
//        let passwordRegex = "^(?=.*[A-Za-z])[A-Za-z\\d]{4}$"
//        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
//        return passwordPredicate.evaluate(with: self)
        isMoreThanThreeCharacters()
    }
}

extension String {
    func isMoreThanThreeCharacters() -> Bool {
         return self.count >= 4
     }
}

extension String {
    var error: Error {
        return  NSError(domain: self, code: 500, userInfo: [NSLocalizedDescriptionKey: self])
    }

    #warning("Later manage this code")
    var success: Error {
        return  NSError(domain: self, code: 200, userInfo: [NSLocalizedDescriptionKey: self])
    }

}

