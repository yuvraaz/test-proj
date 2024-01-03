//
//  VarietyAnalysisOverViewViewModel.swift
//
//
//

import SwiftUI
import Foundation
import Reachability

public func isInternetAvailable() -> Bool {
    let reachability = try? Reachability()
    return reachability?.connection != .unavailable
}

class ScenarioPlayerViewModel: BaseViewModel, ObservableObject, PastActionAPI, AquisitionAPI, SampleRemoteIdAPI, SampleAPI, TargetSampleAPI {
    
    enum ScenrioPlayerStep: CaseIterable {
        case identifySample,declareCategory, declareLabel, declareNumber, declareImage, pictureCollection, prediction
        
        var genericName: String {
            switch self {
            case .identifySample:
                return "de-barcode-text-remote-id"
            case .declareCategory:
                return ""
            case .declareLabel:
                return "generic-freetext-sample-identifier"
            case .declareNumber:
                return ""
            case .declareImage:
                return ""
            case .pictureCollection:
                return "de-pictures-collection-precision-silo-multi"
            case .prediction:
                return "inarix-species-composition-seed"
            }
        }
    }
    
    enum ScenarioPlayerAPI {
        case createPastAction,createSample,createTargetSample, createAndAuisition, createSampleIdIfNeeded, createRemoteID, finalAPICall, None
    }
    
    private var stuckAPI: ScenarioPlayerAPI = .None
    
    @Published var isBusy = true
    @Published var error: Error?
    
    @Published var showAlert: Bool?
    @Published var showAlertWithRetry: Bool?
    var player: ScenarioPlayerComponent
    private var scenarioID: Int
    
    private var pastAction: PastAction?
    private var sample: Sample?
    private var targetSample: TargetSample?
    private var acquisition: Acquisition?
    private var sampleRemoteId: SampleRemoteId?
    @Published var scenarioResponse: PackageScenarioResponseParent?
    private var executingOfflineData: Bool = false
     var scenrioPlayerSteps: [ScenrioPlayerStep] = []
    
    init(player: ScenarioPlayerComponent, scenarioID: Int) {
        self.player = player
        self.scenarioID = scenarioID
    }
    
    func getNumberOfSteps() {
        scenarioResponse = PackagePreviewData.load(name: "ScenarioResponse")
        let scenarioIdData = scenarioResponse?.data?.first(where: { packageScenarioResponse in
            packageScenarioResponse.id == 606  // 606 is scenarioId (make this dynamic)
            
        })
        
     scenrioPlayerSteps = scenarioIdData?.latestScenarioInstance?.steps?.compactMap({ genericName in
            return getStep(forGenericName: genericName)
        }) ?? []
    
        for instanceStep in scenarioIdData?.latestScenarioInstance?.scenarioInstanceSteps ?? [] {
            if (instanceStep.v2LabelTemplate == nil || instanceStep.v2LabelTemplate?.labelTemplateID == nil) {
            } else {
                if !scenrioPlayerSteps.contains(.declareCategory) {
                    scenrioPlayerSteps.append(.declareCategory)
                }
            }
        }
        
    }
    
    func getStep(forGenericName genericName: String) -> ScenrioPlayerStep? {
        for case let step in ScenrioPlayerStep.allCases where step.genericName == genericName {
            return step
        }
        return nil
    }
    
    func createPastAction() {
        if !checkInternetAndSetBusyIfFalse() { return }
        
        isBusy = true
        if environment == .development {
            pastAction = PackagePreviewData.load(name: "PastAction")
            self.isBusy = false
            return
        }
        
        createPastAction(scenarioID: scenarioID) { [weak self] pastAction in
            guard let self = self else { return }
            self.pastAction = pastAction
            self.createSample(success: { _ in
            })
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
//            self.showAlert = true
            self.showAlertWithRetry = true
            stuckAPI = .createPastAction
        }
        
    }
    
    func createSample(success: @escaping (PastAction) -> ()) {
        if !checkInternetAndSetBusyIfFalse() { return }
        isBusy = true
        if environment == .development {
            sample = PackagePreviewData.load(name: "Sample")
            self.isBusy = false
            return
        }
        
        createSample(originScenarioInstanceId: pastAction?.originScenarioInstanceID ?? 0, originPastActionId: pastAction?.id ?? "" ) { [weak self] pastAction in
            guard let self = self else { return }
            self.pastAction = pastAction
            self.createTargetSample()
            
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
//            self.showAlert = true
            self.showAlertWithRetry = true
            stuckAPI = .createSample
        }
        
    }
    
    func createTargetSample() {
        if !checkInternetAndSetBusyIfFalse() { return }
        if environment == .development {
            targetSample = PackagePreviewData.load(name: "TargetSample")
            self.isBusy = false
            return
        }
        isBusy = true
        createTargetSample(originPastActionId: pastAction?.originScenarioInstanceID ?? 0, sampleId: player.sampleId ?? "") { targetSample in
            self.targetSample = targetSample
            self.createAndAuisition()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
//            self.showAlert = true
            self.showAlertWithRetry = true
            stuckAPI = .createTargetSample
        }
    }
    
    func createAndAuisition() {
        if checkExecutingOfflineDataAndColdUpload() {  return }
        if !checkInternetAndSetBusyIfFalse() { return }
        isBusy = true
        if environment == .development {
            acquisition = PackagePreviewData.load(name: "Acquisition")
            self.isBusy = false
            return
        }
        
        createAquisition(sampleId: player.sampleId ?? "", originScenarioInstanceId: targetSample?.originScenarioInstanceID ?? 0, originPastActionId: sample?.originPastActionID ?? "") { acquisition in
            self.acquisition = acquisition
            self.createRemoteID()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
//            self.showAlert = true
            self.showAlertWithRetry = true
            stuckAPI = .createAndAuisition
        }
        
    }
    
    func createSampleIdIfNeeded(success: @escaping () -> ())  {
        if player.sampleId == nil {
            if !checkInternetAndSetBusyIfFalse() { return }
            
            createSample(success: { sample in
                //                self.createRemoteID()
                self.player.scenarioPlayerRetrievedData.sampleId = sample.id
                success()
            })
        } else {
            //            createRemoteID()
            success()
        }
        
    }
    
    func createRemoteID() {
        if checkExecutingOfflineDataAndColdUpload() { return }
        if !checkInternetAndSetBusyIfFalse() { return }
        
        isBusy = true
        if environment == .development {
            self.sampleRemoteId = PackagePreviewData.load(name: "SampleRemoteId")
            self.isBusy = false
            return
        }
        
        createRemoteId(remoteId: "", sampleId: player.sampleId ?? "") { sampleRemote in
            self.sampleRemoteId = sampleRemote
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
//            self.showAlert = true
            self.showAlertWithRetry = true
            stuckAPI = .createRemoteID
        }
    }
    
    func createVariety() {
        createSampleIdIfNeeded {
            self.createRemoteID()
        }
    }
    
    func uploadImage() {
        
    }
    
    
    func finalAPICall() {
        if checkExecutingOfflineDataAndColdUpload() { return }
        if !isInternetAvailable() {
            PackageGlobalConstants.KeyValues.scenarioPlayerRemainingUploads.append(player.scenarioPlayerRetrievedData)
        }
        var apiResponseSucceeded: Bool = true
        
        // MARK: - API CALLS
        if executingOfflineData {
            var apiResponseSucceeded: Bool = true
            
            if apiResponseSucceeded {
                PackageGlobalConstants.KeyValues.scenarioPlayerRemainingUploads.removeFirst()
                executeUploadOfflineData()
            }
        }
        
    }
    
    func executeUploadOfflineData() {
        if let  scenariPlayerOfflineData = PackageGlobalConstants.KeyValues.scenarioPlayerRemainingUploads.first {
            executingOfflineData = true
            createPastAction()
        }
    }
    
    func checkExecutingOfflineDataAndColdUpload() -> Bool {
        return executingOfflineData == true &&  PackageGlobalConstants.KeyValues.pauseColdUpload == true
    }
    
    func checkInternetAndSetBusyIfFalse() -> Bool {
        if !isInternetAvailable() {
            self.isBusy = false
        }
        return isInternetAvailable()
    }
    
    func retryAPI() {
        showAlertWithRetry = false
        switch stuckAPI {
        case .createPastAction:
            createPastAction()
        case .createSample:
            createSample(success: {_ in })
        case .createTargetSample:
            createTargetSample()
        case .createAndAuisition:
            createAndAuisition()
        case .createSampleIdIfNeeded:
            createSampleIdIfNeeded(success: {})
        case .createRemoteID:
            createRemoteID()
        case .finalAPICall:
            finalAPICall()
        case .None: break
        }

    }
    
    

    
}
