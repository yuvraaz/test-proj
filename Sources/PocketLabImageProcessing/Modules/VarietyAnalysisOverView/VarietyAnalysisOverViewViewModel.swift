//
//  VarietyAnalysisOverViewViewModel.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import SwiftUI
import Foundation

class VarietyAnalysisOverViewViewModel: BaseViewModel, ObservableObject, PastActionAPI, AquisitionAPI, SampleRemoteIdAPI, SampleAPI, TargetSampleAPI {
    
    @Published var isBusy = true
    @Published var error: Error?
 
    private var showAlert: Bool?
    private var player: ScenarioPlayerComponent
    private var scenarioID: Int
    
    private var pastAction: PastAction?
    private var sample: Sample?
    private var targetSample: TargetSample?
    private var acquisition: Acquisition?
    private var sampleRemoteId: SampleRemoteId?
    
    init(player: ScenarioPlayerComponent, scenarioID: Int) {
        self.player = player
        self.scenarioID = scenarioID
    }
    
    func createPastAction() {
        isBusy = true
        if environment == .development {
            pastAction = PackagePreviewData.load(name: "PastAction")
            self.isBusy = false
            return
        }
        
        createPastAction(scenarioID: scenarioID) { [weak self] pastAction in
            guard let self = self else { return }
            self.pastAction = pastAction
            self.createSample()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
            self.showAlert = true
        }

    }

    func createSample() {
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
    
    func createRemoteID() {
        isBusy = true
        if environment == .development {
            self.sampleRemoteId = PackagePreviewData.load(name: "SampleRemoteId")
            self.isBusy = false
            return
        }
        
        createSampleRemoteId(remoteId: "", sampleId: player.sampleId ?? "") { sampleRemote in
            self.sampleRemoteId = sampleRemote
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.isBusy = false
            self.error  = error
            self.showAlert = true
        }
    }
    
}
