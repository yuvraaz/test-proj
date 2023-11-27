//
//  TargetSampleAPI.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation


public protocol TargetSampleAPI {
    func createTargetSample(originPastActionId: Int, sampleId: String, success: @escaping (TargetSample) -> (), failure: @escaping (Error) -> ())
}

 extension TargetSampleAPI {
     public func createTargetSample(originPastActionId: Int, sampleId: String, success: @escaping (TargetSample) -> (), failure: @escaping (Error) -> ()) {
        let urlSession = URLSession.shared
        let data = [
            "targetSampleId": sampleId

        ] as [String : Any]
        let request = PackageEndPoint.targetsample(pastActionId: "\(originPastActionId)").request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}
