//
//  PastActionAPI.swift
//


import Foundation

public protocol PastActionAPI {
    func createPastAction(scenarioID: Int, success: @escaping (PastAction) -> (), failure: @escaping (Error) -> ())
}

 extension PastActionAPI {
    public func createPastAction(scenarioID: Int, success: @escaping (PastAction) -> (), failure: @escaping (Error) -> ()){
        let urlSession = URLSession.shared
        
        let metaData = [
            "appVersion": getAppVersion(),
            "osName": "",
            "osVersion": "",
            "manufacturer": ""
        ] as [String : Any]
        let data = [
                "originScenarioInstanceId": scenarioID,
                "metadata": metaData
        ] as [String : Any]
        
        let request = PackageEndPoint.pastAction.request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
}
