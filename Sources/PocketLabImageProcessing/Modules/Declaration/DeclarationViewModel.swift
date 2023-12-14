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
            
            let scenarioIdData = scenarioResponse?.data?.first(where: { packageScenarioResponse in
                packageScenarioResponse.id == 600  // 600 is scenarioId
            })
            
            optionalArray = scenarioIdData?.latestScenarioInstance?.scenarioInstanceSteps?.first(where: { packageScenarioResponse in
                    packageScenarioResponse.v2LabelTemplate?.generatedByLabelTemplateConfig?.substitutionDictV2?.optionalArray?.count != 0
                    
                })?.v2LabelTemplate?.generatedByLabelTemplateConfig?.substitutionDictV2?.optionalArray ?? []
            
            

// MARK: - for generatedByLabelTemplateConfig json
            
            var generatedByLabelTemplateConfig = scenarioIdData?.latestScenarioInstance?.scenarioInstanceSteps?.first(where: { packageScenarioResponse in
                packageScenarioResponse.v2LabelTemplate?.generatedByLabelTemplateConfig?.substitutionDictV2?.optionalArray?.count != 0
                
            })?.v2LabelTemplate?.generatedByLabelTemplateConfig
            
            
            print(generatedByLabelTemplateConfig?.dictionaryRepresentation ?? [:]);
            // let say you need to modify generatedByLabelTemplateConfig id then
            generatedByLabelTemplateConfig?.id = "234"
            
            let cords = [
                  "speed": 0,
                  "heading": 0,
                  "accuracy": 11.974,
                  "altitude": 83.5,
                  "latitude": 48.8788982,
                  "longitude": 2.2964244,
                  "altitudeAccuracy": 1
            ] as [String : Any]
            
            let locationHeader = [
                "coords": cords,
                "mocked": false,
                "timestamp": 1702481826752
            ] as [String : Any]
            
            
            let data = [
                "id": "8d25ab8a-300c-45f7-96c0-63e833c371e5",
                  "labelTemplateId": "065d0d53-2808-45b8-9769-ac42e8e77f1c",
                  "labelTemplateVersionId": "a95a1b56-8bab-4410-928a-f3db09c0789e",
                  "sampleId": "28325eec-e987-4c57-9a56-58789c407866",
                  "creatorId": "b794e409-34a8-492a-8dcf-7c0165e77d68",
                  "ownerOrgId": 2,
                  "originScenarioInstanceId": 1287,
                  "originPastActionId": "1ccaa067-0d75-475f-a665-99d94061be23",
                  "rawInput": "Faro",
                  "labelText": "faro",
                  "metadata": locationHeader,
                "generatedByLabelTemplateConfig": generatedByLabelTemplateConfig?.dictionaryRepresentation ?? [:]
            ] as [String : Any]
  
          print(data)
    
            
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
