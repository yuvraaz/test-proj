//
//  UploadImagesAPI.swift
//

import Foundation
import UIKit

public protocol UploadImagesAPI {
//     func uploadImage(image: PackageImageModel, success: @escaping (PackageImageInfo) -> (), failure: @escaping (Error) -> ())
    func uploadImage(image: PackageImageModel, success: @escaping (String) -> (), failure: @escaping (Error) -> ())
     func uploadImageStatus(fieldId: String, success: @escaping (PackageImageDetail) -> (), failure: @escaping (Error) -> ())
}

public extension UploadImagesAPI {
    
    /// uploadImage
    /// - Parameters:
    ///   - image: image is Model
    
//    MARK: for checking only status code for success
     func uploadImage(image: PackageImageModel, success: @escaping (String) -> (), failure: @escaping (Error) -> ()) {
        let urlSession = URLSession.shared
        
        let paramsOfCaptureDevice = [
            "id": UIDevice.current.model,
            "name": UIDevice.current.name,
            "os": "iOS",
            "version": UIDevice.current.systemVersion
        ]
        
        var params = [String : Any]()
        params["site"] = image.site
        params["x"] =  image.x
        params["y"] =  image.y
        params["z"] =  image.z
        params["yaw"] =  image.yaw
        params["captured_device"] = paramsOfCaptureDevice
        
        let request = PackageEndPoint.uploadImage.request(body: params)
        let file = [URLSession.PackageFile(name: "image", fileName: "image.jpg", data: image.imageData, contentType: "image/jpeg")]
         urlSession.upload(request: request, params: params, files: file, success: success) { error in
             if error as NSError == PackageGlobalConstants.Error.successful {
                 success("Successfully Uploaded")
             } else {
                 failure(error)
             }
         }
    }
    
     func uploadImageStatus(fieldId: String, success: @escaping (PackageImageDetail) -> (), failure: @escaping (Error) -> ()){
        let urlSession = URLSession.shared
        let data = [
            "isUploaded": true
        ]
        let request = PackageEndPoint.uploadImageStatus(fieldId: fieldId).request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
    
}

public func convertUIImageToDataWithCompression(image: UIImage, compressionQuality: CGFloat) -> Data {
    if let compressedData = image.jpegData(compressionQuality: compressionQuality) {
        return compressedData
    }
    return  Data()
}
