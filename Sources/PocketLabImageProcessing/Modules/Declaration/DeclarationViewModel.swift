//
//  DeclarationViewModel.swift
//
//
//  Created by Amrit Duwal on 12/11/23.
//

import Foundation

public class DeclarationViewModel: BaseViewModel, ObservableObject {
    
    @Published public var isBusy = false
     
    public var showAlert: Bool?
    public var showSuccessAlert: Bool = false
    @Published var optionalArray: [OptionalArray] = []
    @Published var scenarioResponse: PackageScenarioResponseParent?
    @Published var selectedOptionalValue: OptionalArray?
    
    public func getData() {
        isBusy = true
        
        if environment == .development {
            scenarioResponse = PackagePreviewData.load(name: "ScenarioResponse")
            optionalArray =   scenarioResponse?.data?.first(where: { packageScenarioResponse in
                packageScenarioResponse.id == 600  // 600 is scenarioId
            })?
                .latestScenarioInstance?.scenarioInstanceSteps?.first(where: { packageScenarioResponse in
                    packageScenarioResponse.v2LabelTemplate?.generatedByLabelTemplateConfig?.substitutionDictV2?.optionalArray?.count != 0
                })?.v2LabelTemplate?.generatedByLabelTemplateConfig?.substitutionDictV2?.optionalArray ?? []
            optionalArray = optionalArray.map { element in
                var mutableElement = element
                mutableElement.id = UUID()
                return mutableElement
            }
            print(optionalArray)
            if optionalArray.count == 0 {
                optionalArray = [OptionalArray(dataValue: "tesco", userValue: "Tesco"), OptionalArray(dataValue: "faro", userValue: "Faro")]
                
            }
            self.isBusy = false
            return
        }
//        if environment == .development {
//            self.isBusy = false
//            return
//        }
        
    
    }
    
}
