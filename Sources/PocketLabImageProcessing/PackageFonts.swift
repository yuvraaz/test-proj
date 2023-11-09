import Foundation
import UIKit
import SwiftUI

public struct PackageFonts {
    public static let regularFont10  = "regularFont10".packageFont
    public static let regularFont12  = "regularFont12".packageFont
    public static let regularFont14  = "regularFont14".packageFont
    public static let regularFont16  = "regularFont16".packageFont

    public static let mediumFont10   = "mediumFont10".packageFont
    public static let mediumFont12   = "mediumFont12".packageFont
    public static let mediumFont14   = "mediumFont14".packageFont
    public static let mediumFont16   = "mediumFont16".packageFont
    public static let mediumFont20   = "mediumFont20".packageFont
    
    public static let semiBoldFont14 = "semiBoldFont14".packageFont
    public static let semiBoldFont16 = "semiBoldFont16".packageFont
    
    public static let boldFont10     = "boldFont10".packageFont
    public static let boldFont12     = "boldFont12".packageFont
    public static let boldFont14     = "boldFont14".packageFont
    public static let boldFont16     = "boldFont16".packageFont
    public static let boldFont18     = "boldFont18".packageFont
    public static let boldFont20     = "boldFont20".packageFont
    public static let boldFont22     = "boldFont22".packageFont
    public static let boldFont26     = "boldFont26".packageFont
    public static let boldFont32     = "boldFont32".packageFont
}

public extension String {
    
    var packageFont: Font {
        let fontSize: CGFloat = self.removeAlphabets.toCGFLoatPackage
        var font: Font?
//        switch self {
//        case self where self.contains("regular") : font = UIFont(name: "Lexend-Regular", size: fontSize)?.font
//        case self where self.contains("medium")  : font = UIFont(name : "Lexend-Medium", size : fontSize)?.font
//        case self where self.contains("semiBold"): font = UIFont(name : "Lexend-SemiBold", size : fontSize)?.font
//        case self where self.contains("bold")    : font = UIFont(name : "Lexend-Bold", size : fontSize)?.font
//        default:                                   font = UIFont(name: "Lexend-Regular", size: fontSize)?.font
//        }
        return font ?? self.systemFont
    }
    
    var systemFont: Font {
        let fontSize: CGFloat = self.removeAlphabets.toCGFLoatPackage
        switch self {
        case self where self.contains("regular") : return Font.system(size: fontSize, weight: .regular)
        case self where self.contains("medium")  : return Font.system(size: fontSize, weight: .medium)
        case self where self.contains("semiBold"): return Font.system(size: fontSize, weight: .medium)
        case self where self.contains("bold")    : return Font.system(size: fontSize, weight: .bold)
        default: return Font.system(size: 16, weight: .regular)
        }
    }
    
    var removeAlphabets: String {
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z]", options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        let modifiedString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        return modifiedString
    }
}


public extension String {
    
    var toCGFLoatPackage: CGFloat {
        return CGFloat((self as NSString).doubleValue)
    }
    
}
