//
//  URLSessionTests.swift
//
//
//  Created by Amrit Duwal on 1/5/24.
//

import XCTest
@testable import PocketLabImageProcessing

final class URLSessionTests: XCTestCase {
    
    // Mock URLSession for testing
    class MockURLSession: URLSession {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let task = MockURLSessionDataTask()
            task.completionHandler = {
                completionHandler(self.data, self.response, self.error)
            }
            return task
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        var completionHandler: (() -> Void)?
        
        override func resume() {
            completionHandler?()
        }
    }
    
//  MARK:
    /// put the expected url then expected  model in  result  and endpoint,in this way you can test the api success
    func testDataTaskSuccess() {
        let url = URL(string: "")! // put url here
        let request = URLRequest(url: url)
        let session = MockURLSession()
        session.data = "Test Data".data(using: .utf8)
        
        let apiRequest = PackageAPIRequest(request: request, endPoint: .testScenarioPlayer)
        let dataTask = session.dataTask(request: apiRequest, success: { (result: PackageScenarioResponseParent) in // expected model  for instance PackageScenarioResponseParent
            XCTAssertNotNil(result)
        }, failure: { _ in
            XCTFail("Unexpected failure")
        })
        
        dataTask.execute()
    }
    
    func testDataTaskFailure() {
        let url = URL(string: "https://example.com")!
        let request = URLRequest(url: url)
        let session = MockURLSession()
        session.error = NSError(domain: "API_ERROR", code: 42, userInfo: nil)
        
        let apiRequest = PackageAPIRequest(request: request, endPoint: .acquisition)
        let dataTask = session.dataTask(request: apiRequest, success: { (data: PackageScenarioResponseParent) in
            XCTFail("Unexpected success")
        }, failure: { error in
            XCTAssertEqual((error as NSError).code, 1001)
        })
        
        dataTask.execute()
    }
    
}
