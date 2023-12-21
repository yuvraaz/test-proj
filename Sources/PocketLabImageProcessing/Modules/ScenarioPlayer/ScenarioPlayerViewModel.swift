//
//  VarietyAnalysisOverViewViewModel.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import SwiftUI
import Foundation
import Reachability

public func isInternetAvailable() -> Bool {
    let reachability = try? Reachability()
    return reachability?.connection != .unavailable
}

class ScenarioPlayerViewModel: BaseViewModel, ObservableObject, PastActionAPI, AquisitionAPI, SampleRemoteIdAPI, SampleAPI, TargetSampleAPI {
    
    @Published var isBusy = true
    @Published var error: Error?
 
    private var showAlert: Bool?
     var player: ScenarioPlayerComponent
     var scenarioID: Int
    
    private var pastAction: PastAction?
    private var sample: Sample?
    private var targetSample: TargetSample?
    private var acquisition: Acquisition?
    private var sampleRemoteId: SampleRemoteId?
    
    private var executingOfflineData: Bool = false
    
    init(player: ScenarioPlayerComponent, scenarioID: Int) {
        self.player = player
        self.scenarioID = scenarioID
    }
    
    // steps
    
    func createPastAction() {
        if !isInternetAvailable() {
            self.isBusy = false
            return
        }
        
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
            self.showAlert = true
        }

    }

    func createSample(success: @escaping (PastAction) -> ()) {
        if !isInternetAvailable() {
            self.isBusy = false
            return
        }
        
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
            self.showAlert = true
        }

    }
    
    func createTargetSample() {
        if !isInternetAvailable() {
            self.isBusy = false
            return
        }
        
        isBusy = true
        if environment == .development {
            targetSample = PackagePreviewData.load(name: "TargetSample")
            self.isBusy = false
            return
        }
        
        createTargetSample(originPastActionId: pastAction?.originScenarioInstanceID ?? 0, sampleId: player.sampleId ?? "") { targetSample in
            self.targetSample = targetSample
            self.createAndAuisition()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
            self.showAlert = true
        }
    }
    
    func createAndAuisition() {
        if !isInternetAvailable() {
            self.isBusy = false
            return
        }
        
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
            self.showAlert = true
        }
    
    }
    
    
    func createSampleIdIfNeeded(success: @escaping () -> ())  {
        if player.sampleId == nil {
            if !isInternetAvailable() {
                self.isBusy = false
                return
            }
            
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
        if !isInternetAvailable() {
            self.isBusy = false
            return
        }
        
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
                self.showAlert = true
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
    
}
