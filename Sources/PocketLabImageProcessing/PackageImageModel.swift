//
//  ImageModel.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 9/25/23.
//

import Foundation
import UIKit

public class PackageImageModel: Codable {
    public let imageData: Data
    public var x: String?
    public var y: String?
    public var z: String?
    public var yaw: String?
    public var site: String?
    
    public init(imageData: Data) {
        self.imageData = imageData
    }
    
    public init(imageData: Data, x: String?, y: String?, z: String?, yaw: String?, site: String?) {
        self.imageData = imageData
        self.x = x
        self.y = y
        self.z = z
        self.yaw = yaw
        self.site = site
    }
}

public enum ScenarioStatus {
    case notStarted
    case inProgress
    case completed
}
