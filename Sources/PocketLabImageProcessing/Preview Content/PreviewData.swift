//
//  PackagePreviewData.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 9/14/23.
//

import Foundation


class PackagePreviewData {
    
    private func testDecode<T:Codable>(myCustomClass : T.Type, jsonData: Data , success: @escaping (T)->()) {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: jsonData)
            print(data)
            success(data)
        } catch let error {
            print("TestHelper error: \(error)")
        }
    }
    
    static func load<T: Codable> (name: String) -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try JSONDecoder ().decode (T.self, from: data)
                return results
            } catch {
                print("Error decoding JSON for \(name): \(error)")
                return nil
            }
        } else  {
            print("you mightnot have targeted \(name)")
        }
        return nil
    }
}
