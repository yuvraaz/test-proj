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
    
    public func getData() {
        isBusy = true
        
        if environment == .development {
            scenarioResponse = PackagePreviewData.load(name: "ScenarioResponse")
            optionalArray =   scenarioResponse?.data?.first?.latestScenarioInstance?.scenarioInstanceSteps?.first?.v2LabelTemplate?.generatedByLabelTemplateConfig?.substitutionDictV2?.optionalArray ?? []
            optionalArray = optionalArray.map { element in
                var mutableElement = element
                mutableElement.id = UUID()
                return mutableElement
            }
            print(optionalArray)
            self.isBusy = false
            return
        }
//        if environment == .development {
//            self.isBusy = false
//            return
//        }
        
    
    }
    
}
