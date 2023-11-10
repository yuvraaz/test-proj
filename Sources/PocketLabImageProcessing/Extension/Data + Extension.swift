//
//  Data + Extension.swift
//
//  Copyright © 2021 . All rights reserved.
//

import Foundation

extension Data {
    
    /// convert data to json string
    var packageJsonString: String? { //prettyPrintedBody
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedBody = String(data: prettyPrintedData, encoding: .utf8)
        else {
            return nil
        }
        
        return prettyPrintedBody
    }
    
}
