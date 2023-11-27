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
        // Implement reset
    }

    public func clearAnnotations() {
        // Implement clearing annotations
    }
}

//struct ContentView: View {
//    @StateObject var player = ScenarioPlayerComponent()
//
//    var body: some View {
//        VStack {
//            Text("Scenario Player")
//            Button("Start") {
//                player.start()
//            }
//            Button("Finish") {
//                player.finish()
//            }
//            // Other UI elements and controls
//        }
//        .onAppear {
//            // Initialize the player here or in the ViewModel
//            player.displayResults = false
//            player.setAnnotation(type: .remoteId, value: "my-remote-id")
//            player.setAnnotation(type: .proteinRate, value: 12.5)
//            player.onSuccess(results: nil)
//            player.onError(error: NSError(domain: "Sample Error", code: 0, userInfo: nil))
//            player.setSampleId(id: "uuid-1")
//        }
//    }
//}

// In your app, you can use the ScenarioPlayerComponent similarly to how you did in TypeScript
