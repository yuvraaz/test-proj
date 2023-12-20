//
//  SampleRemoteIdAPI.swift
//
//
//  Created by Amrit Duwal on 11/27/23.
//

import Foundation

public protocol SampleRemoteIdAPI {
     func createRemoteId(remoteId: String, sampleId: String, success: @escaping (SampleRemoteId) -> (), failure: @escaping (Error) -> ())
}

 extension SampleRemoteIdAPI {
     public func createRemoteId(remoteId: String, sampleId: String, success: @escaping (SampleRemoteId) -> (), failure: @escaping (Error) -> ()){
        let urlSession = URLSession.shared
        let data = [
            "remoteId":remoteId
        ] as [String : Any]
        let request = PackageEndPoint.sampleRemoteId(id: sampleId).request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}

func getAppVersion() -> String {
     if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
         return appVersion
     } else {
         return "Unknown"
     }
 }
