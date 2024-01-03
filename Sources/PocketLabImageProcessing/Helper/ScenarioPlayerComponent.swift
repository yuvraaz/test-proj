//
//  ScenarioPlayerComponent.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 11/27/23.
//

import SwiftUI

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

public struct ScenarioPlayerAllRequiredData: Codable {
    var sampleId: String?
    var identificationcode: String?
    var images: [Data] = []
    var selectedVariety: OptionalArray?
    var Note: String?
}

public class ScenarioPlayerComponent: ObservableObject {
    @Published public var displayResults: Bool = false
    @Published public var remoteId: String?
    @Published public var proteinRate: Double?
    @Published public var sampleId: String?
    @Published public var annotationType: AnnotationType?
    
    public var onSuccess: ((String) -> ())?
    public var onError: ((String) -> ())?
    public var onCancel: (() -> ())?
    
    public var scenarioPlayerRetrievedData: ScenarioPlayerAllRequiredData = ScenarioPlayerAllRequiredData(identificationcode: nil, images: [], selectedVariety: nil, Note: nil)
    
    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(apiResponse(_:)), name: .apiResponse, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private var scenarioPlayerViewModel: ScenarioPlayerViewModel?

    public func setAnnotation(type: AnnotationType, value: Any) {
        annotationType = type
        switch type {
        case .remoteId: remoteId = value as? String
        case .proteinRate: proteinRate = value as? Double
        default: break
        }
    }
    
    public func setSampleId(id: String) {
        sampleId = id
    }

//    public func start() {
//        // Implement start functionality
//    }

    public func onSuccess(results: String) {
        onSuccess?(results)
    }

    public func onError(error: String) {
        onError?(error)
    }

    public func cancel() {
        onCancel?()
    }

    public func finish() {
        PackageGlobalConstants.KeyValues.apiHistoryList = []
    }

    public func reset() {
        remoteId = nil
        proteinRate = nil
        sampleId = nil
        scenarioPlayerRetrievedData  = ScenarioPlayerAllRequiredData(identificationcode: nil, images: [], selectedVariety: nil, Note: nil)
    }

    public func clearAnnotations() {
        remoteId = nil
        proteinRate = nil
        sampleId = nil
    }
    
    public func executeUploadOfflineData() {
    scenarioPlayerViewModel = ScenarioPlayerViewModel(player: self, scenarioID: 0)
        scenarioPlayerViewModel?.executeUploadOfflineData()
    }
    
    @objc func apiResponse(_ notification: Notification) {
        if let notification = notification.object as? ResponseMetaData {
            switch notification.error ?? nil {
            case nil: onSuccess(results: notification.response ?? "")
            default: onError(error: notification.error ?? "")
            }
        }
     }
    
}
