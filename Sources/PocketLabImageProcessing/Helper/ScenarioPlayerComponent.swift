//
//  ScenarioPlayerComponent.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 11/27/23.
//

import SwiftUI

// Public SDK
public class ComponentsFactory {}

public class ScenarioPlayerResults {}

public enum AnnotationType {
    case remoteId
    case variety
    case proteinRate
    case customRemoteId(id: String)
    case customVariety(name: String)
    case customProteinRate(percent: Double)
    case customRemoteIdAndVariety(id: String,name: String)
}

public class ScenarioPlayerComponent: ObservableObject {
    @Published public var displayResults: Bool = false
    @Published public var remoteId: String?
    @Published public var proteinRate: Double?
    @Published public var sampleId: String?
    @Published public var annotationType: AnnotationType?
    
    public init() {}

    public func setAnnotation(type: AnnotationType, value: Any) {
        annotationType = type
        switch type {
        case .remoteId:
            remoteId = value as? String
        case .proteinRate:
            proteinRate = value as? Double
        default:
            break
        }
    }
    
    public func setSampleId(id: String) {
        sampleId = id
    }

    public func start() {
        // Implement start functionality
    }

    public func onSuccess(results: Any?) {
        // Implement success handling
    }

    public func onError(error: Error) {
        // Implement error handling
    }

    public func cancel() {
        // Implement cancellation
    }

    public func finish() {
        // Implement finishing
    }

    public func reset() {
        remoteId = nil
        proteinRate = nil
        sampleId = nil
    }

    public func clearAnnotations() {
        // Implement clearing annotations
    }
    
}
