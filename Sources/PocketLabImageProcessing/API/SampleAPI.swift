//
//  SampleAPI.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation

public protocol SampleAPI {
     func createSample(originScenarioInstanceId: Int,originPastActionId: String, success: @escaping (PastAction) -> (), failure: @escaping (Error) -> ())
}

 extension SampleAPI {
     public func createSample(originScenarioInstanceId: Int,originPastActionId: String, success: @escaping (PastAction) -> (), failure: @escaping (Error) -> ()) {
        let urlSession = URLSession.shared
        let data = [
                "originScenarioInstanceId": originScenarioInstanceId,
                "originPastActionId": originPastActionId

        ] as [String : Any]
        let request = PackageEndPoint.sample.request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}
