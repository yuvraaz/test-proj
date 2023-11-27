//
//  AquisitionAPI.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation

public protocol AquisitionAPI {
    func createAquisition(sampleId: String, originScenarioInstanceId: Int, originPastActionId: String , success: @escaping (Acquisition) -> (), failure: @escaping (Error) -> ())
}

public extension AquisitionAPI {
    func createAquisition(sampleId: String, originScenarioInstanceId: Int, originPastActionId: String , success: @escaping (Acquisition) -> (), failure: @escaping (Error) -> ()) {
        let urlSession = URLSession.shared
        let data = [
                "sampleId": sampleId,
                "originScenarioInstanceId": originScenarioInstanceId,
                "originPastActionId": originPastActionId
        ] as [String : Any]
        let request = PackageEndPoint.acquisition.request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}
